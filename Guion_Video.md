# Guion del video (máximo 8 minutos)

Uso interno del equipo. No es parte del informe.

- Lo que se dice en voz alta está en **inglés** y con palabras simples. Las notas para el equipo están en español.
- `[corchetes]` = todavía no existe o falta confirmar. Se llena antes de grabar.
- Velocidad de cálculo: unas 130 palabras por minuto. Se apunta a **7:40**, para dejar 20 segundos de margen.
- Cada persona graba su parte por separado y luego se unen en orden.

## Tiempos

| Orden | Quién | Diapositivas | Tiempo objetivo |
|---|---|---|---|
| 1 | Carla | 1 a 5 | 1:40 |
| 2 | Johao | 6 a 8 | 1:35 |
| 3 | Geovanny | 9 a 10 | 2:10 |
| 4 | Darwin | 11 a 15 | 2:15 |
| | **Total** | | **7:40** |

---

## 1. Carla: sistema, arquitectura y sprints (1:40)

Todo sale de las secciones 1 (contexto), 2 (arquitectura) y 9 (contribuciones) del informe, y de la sección 3 de Geovanny para las historias aceptadas. Son unas 230 palabras: cerca de 1:45 hablando con calma.

**Diapositiva 1 (portada)** (unos 10 segundos)
> Hello, we are Group 4, from ESPOL, Software Engineering II. This is our midterm presentation of Leodega. I am Carla Gutierrez, and I am here with Joao, Geovanny and Darwin.

**Diapositiva 2 (orden)** (unos 10 segundos)
> In eight minutes, we will show our system, our risk-based test plan, and three live test cases on the deployed system. We end with our code quality and CI results.

**Diapositiva 3 (contexto)** (unos 25 segundos)
> Our client and Product Owner is Leonardo Castro. In Guayaquil, people who need storage find it through informal deals, with no guarantee of safety or legal compliance. And owners with empty warehouses have no formal way to offer them. Leodega connects both. It has three roles: the storage manager publishes warehouses, the administrator checks them and their fire permit, and the client searches, books and pays. A client can also work for a company.

**Diapositiva 4 (arquitectura)** (unos 35 segundos)
> This is our architecture. One Laravel API holds all the business rules. Two React apps use it: the Leodega web app, and Leodeguita, an installable mobile web app. In production, Vercel serves the two apps, and Railway runs the API in a Docker container, with PostgreSQL and a volume for uploaded files. Why these tools? We kept the stack of the previous team, so we did not rewrite the system. We made Leodeguita a web app instead of React Native, so we use one language and install it from the browser. And PostgreSQL gives us the transactions we need to avoid double bookings. Each sprint is deployed from its own tag.

**Diapositiva 5 (sprints)** (unos 25 segundos)
> We finished two sprints. Sprint 1, from October 1 to October 21, delivered login for web and mobile, warehouse management and moderation, and search and booking with simulated payment. Sprint 2, from October 22 to November 13, delivered companies: organizations, invitations, context switching and company reservations. The client accepted all 16 and all 8 stories. Darwin and Geovanny built these two sprints, and Joao and I will build Sprints 3 and 4. Now, Joao will explain our test plan.

Notas:
- La razón de dividirnos en pares está en la sección 9: el proyecto empezó antes de la materia (primer commit el 2026-09-01). No hace falta decirla completa en el video; si sobra tiempo, se puede agregar una frase.
- "All 16 and all 8 stories accepted" está respaldado por las cartas de aceptación firmadas por el Product Owner el 2026-11-16 (sección 8, C13 y C14).

---

## 2. Johao: historias de alto riesgo y técnica de diseño (1:35)

**Diapositiva 6 (divisor)**
> Now, our test plan. We did not test every story the same way. We tested more where a failure costs more.

**Diapositiva 7 (matriz de riesgo)**
> For each story, we rate two things from 1 to 5: how likely it is to fail, and how bad it would be. We multiply them. A score of 10 or more is high priority. Three stories are high priority: HUG-04, warehouse registration with a fire department permit; HUA-01, permit validation by the administrator; and HUE-05, reservations made for a company. For these, every acceptance criterion has a test. Medium stories get the main flow and the most likely error. Low stories get a quick check, or wait for a later sprint. We have limited time, so we spend it where the risk is higher.

**Diapositiva 8 (técnica)**
> To choose test inputs, we use design techniques. For example, equivalence partitions for HUE-05. The company is sent in a request header. We found four groups: no header, a company you belong to, a company you do not belong to, and an inactive company. One test for each group is enough. Geovanny will now run the first one live.

Nota: la técnica y la historia las confirma Johao. Los cuatro grupos salen de la sección 4.4 del informe.

---

## 3. Geovanny: casos en vivo 1 y 2 (2:10)

Cada caso: se dice la historia, la entrada y lo esperado **antes** de ir al navegador. Después se hace en vivo. Al volver se dice lo obtenido y el resultado.

**Diapositiva 9 (TC-HUE-05-01, válido)**

Antes de ir al navegador:
> Live case 1. Story HUE-05, reservations for a company. Input: I reserve a warehouse as the company Andina Logística. Expected: the reservation belongs to the company, and the company wallet is charged.

En vivo (mientras narra): selector "Modo personal" → Andina Logística; abrir Galpón Logístico Centro; Reservar; fechas 12/01/2026 a 01/01/2027; Confirmar reserva.
> I choose the company. I open the warehouse. I pick free dates. I confirm.

Al volver:
> Obtained: the reservation is confirmed, and it is paid with the company wallet. The wallet balance went down by 540 dollars. Result: pass.

**Diapositiva 10 (TC-HUC-03-02, inválido)**

Antes de ir al navegador:
> Live case 2. Story HUC-03, reservations with a date conflict. This one is an invalid case. Input: dates that overlap with an occupied period. Expected: the system rejects them and creates nothing.

En vivo: abrir Bodega Vía a Daule; Reservar; inicio 12/10/2026, fin 12/15/2026. **No pulsar "Confirmar reserva".**
> The warehouse is already booked in this period. I type dates inside it.

Al volver:
> Obtained: the fields turn red, the message says the dates are not available, and no reservation was created. Result: pass.

---

## 4. Darwin: caso en vivo 3, calidad de código y CI (2:15)

**Diapositiva 11, antes del paso (TC-HUE-04-04, límite)** (unos 15 segundos)
> Live case 3, a boundary value. Story HUE-04: the RUC of a company must have exactly 13 digits. Input: a RUC with 12 digits. Expected: the form rejects it, and nothing is created.

**En vivo** (unos 30 segundos): sesión de Ana; selector "Modo personal" → Crear organización; razón social `Prueba Limite SA`; correo `prueba@limite.test`; RUC `179214673900`; pulsar Crear organización.
> I type a RUC with 12 digits and click create.

**Diapositiva 11, pulsa `→`** (unos 10 segundos)
> Obtained: the form says the RUC must have 13 digits, and nothing was created. Result: pass.

**Diapositiva 12 (análisis estático)** (unos 25 segundos)
> Now, code quality. We ran PHPStan, PHPMD, Pint and ESLint, before and after our fixes. With the project baseline, PHPStan shows zero errors, but the baseline hides old ones. Without it, Sprint 2 went from 225 to 126 errors. ESLint errors went to zero. PHPMD still has 39 violations, and we report them.

**Diapositiva 13 (CI)** (unos 25 segundos)
> Our GitHub Actions pipeline has three jobs: backend, frontend and leodeguita. It runs on every push and pull request to main and develop. It ran seven times. The first three failed because PHPStan found real code errors. We fixed them, and the last four passed. In the last run, the backend ran 1,820 tests, and all passed.

**Diapositivas 14 y 15 (resumen y cierre)** (unos 10 segundos)
> In short: the tests pass, and the pipeline now catches problems before they reach main. Thank you.

Tiempo estimado de tu parte: unas 190 palabras (1:30) más 30 segundos de demo en vivo, cerca de 2:00. Te sobran unos 15 segundos de margen.

---

## Antes de grabar (todos)

1. Abrir `https://backend-production-7789f403.up.railway.app/up`: debe dar 200.
2. Abrir el catálogo unos minutos antes, para que el backend no esté dormido.
3. Iniciar sesión **antes** de grabar, con la contraseña fuera de pantalla.
4. Las fechas del navegador van en formato mm/dd/yyyy.
5. En el deck: `→` avanza, `←` retrocede. En la diapositiva 11 el primer `→` revela Obtained y Result.
6. Ensayar cada caso al menos una vez. El caso 1 (Geovanny) **escribe datos reales**: ensayarlo en local y hacerlo una sola vez en el despliegue.
7. Darwin: **no agregues un dígito** al RUC. Uno de 13 dígitos que termine en 001 es válido y crearía una empresa real.
8. Darwin: antes de grabar, confirmar que los números 1,820, 1,553 y 478 coinciden con lo que muestra el sistema.

## Contenido y recursos de cada diapositiva

Qué tiene que decir cada diapositiva (el mensaje, no el texto exacto) y qué imágenes o recursos van en ella. Todo sale del informe o del proyecto; la última columna dice de dónde, para poder revisarlo.

| Diap. | Quién | Qué debe decir | Imágenes y recursos | Fuente |
|---|---|---|---|---|
| 1. Portada | Carla | Materia (Software Engineering II, Midterm), nombre del sistema, equipo "Group 4", los cuatro integrantes, cliente y fecha (noviembre 2026). | Logo de ESPOL y logo de Leodega. Nombres completos: Carla Gutierrez, Joao Dorado, Geovanny Díaz, Darwin Díaz. | Portada del informe, `config/metadata.tex` |
| 2. Orden | Carla | Los cuatro bloques del video, quién habla en cada uno y el tiempo. | Solo texto: Carla (sistema, arquitectura, sprints), Joao (plan de pruebas), Geovanny (casos en vivo 1 y 2), Darwin (caso 3, análisis estático, CI). | Tabla "Tiempos" de este guion |
| 3. Contexto | Carla | Cliente y Product Owner: Ing. Leonardo Castro. El problema: en Guayaquil se alquila almacenamiento con acuerdos informales, sin garantía de seguridad ni legalidad, y los dueños de bodegas vacías no tienen un canal formal. Leodega conecta ambos lados. Tres roles: administrador, gestor de bodegas y cliente (que puede actuar por una organización). | Una captura del catálogo desplegado, por ejemplo de `figures/sprints/sprint1-deployment-1.png`. Íconos o recuadros simples para los tres roles. | Sección 1.1 y 1.3 |
| 4. Arquitectura | Carla | Un backend (API REST en Laravel) con todas las reglas de negocio y dos clientes React: la web y Leodeguita (PWA instalable). Despliegue: Vercel sirve las dos apps; Railway corre la API en Docker con PostgreSQL y un volumen para archivos. Tres decisiones con su motivo: mantener la pila del equipo anterior, PWA en vez de React Native, PostgreSQL por las transacciones de reservas. | Los diagramas de componentes y de despliegue del informe (Figuras de la sección 2; se pueden recortar del PDF). Pila exacta: Laravel 12, PHP 8.2, React 19 + TypeScript + Vite, PostgreSQL, Railway, Vercel. Tags: `sprint1-deploy` (3bbef9d) y `sprint2-deploy` (9b8427d). | Sección 2, tabla de decisiones de tecnología y tabla de versiones desplegadas |
| 5. Sprints | Carla | Objetivo y fechas de cada sprint: S1 del 1 al 21 de octubre, S2 del 22 de octubre al 13 de noviembre. 16 y 8 historias, todas aceptadas. Darwin y Geovanny hicieron S1 y S2; Carla y Joao harán S3 y S4. | Capturas del backlog de Jira: `figures/sprints/sprint1-backlog.png` y `figures/sprints/sprint2-backlog.png`. Como apoyo, `figures/sprints/sprint2-deployment.png`. | Tabla del plan en la sección 1, sección 3, sección 9 |
| 6. Divisor del plan de pruebas | Joao | Se prueba más donde una falla cuesta más. | Diapositiva de transición, sin datos. | Sección 4 |
| 7. Matriz de riesgo | Joao | Probabilidad × impacto, de 1 a 5 cada uno; 10 o más es prioridad alta. Las tres historias altas: HUG-04, HUA-01 y HUE-05. Qué cobertura recibe cada nivel. | Matriz 5×5 con las tres historias en su celda. | Sección 4 |
| 8. Técnica de diseño | Joao | Particiones de equivalencia aplicadas a HUE-05: cuatro grupos según la cabecera de organización, un caso por grupo. | Tabla con los cuatro grupos: sin cabecera, miembro, no miembro, organización inactiva. | Sección 4.4 |
| 9. Caso en vivo 1 | Geovanny | TC-HUE-05-01, caso válido: historia, entrada y resultado esperado antes de la demo; obtenido y resultado después. | Tabla Historia / Entrada / Esperado / Obtenido / Resultado. Navegador con la web desplegada (`leodega-frontend.vercel.app`) y sesión iniciada antes de grabar. | Sección 6, parte de Geovanny en este guion |
| 10. Caso en vivo 2 | Geovanny | TC-HUC-03-02, caso inválido: fechas que chocan con una reserva existente se rechazan y no se crea nada. | Misma tabla y el navegador. | Sección 6 |
| 11. Caso en vivo 3 | Darwin | TC-HUE-04-04, valor límite: un RUC de 12 dígitos se rechaza. | Misma tabla y el navegador. | Sección 6 |
| 12. Análisis estático | Darwin | PHPStan, PHPMD, Pint y ESLint, antes y después de las correcciones; el baseline de PHPStan oculta errores viejos. | Tabla de antes y después de la sección 5. | Sección 5 |
| 13. Integración continua | Darwin | Tres jobs (backend, frontend, leodeguita) en cada push y PR a `main` y `develop`. Siete ejecuciones: las tres primeras fallaron por errores reales de PHPStan y las últimas cuatro pasaron. | Captura de la página de GitHub Actions. Corrida R7 (43933294028, 90dbf81, 2026-11-16, aprobada) y R3 (41942989196, d563d66, fallida). | Sección 7 |
| 14. Resultados | Darwin | Cuántas pruebas pasan en cada app y qué falta en la calidad del código. | Capturas de las pruebas: `figures/tests/sprint2-backend-phpunit.png`, `sprint2-frontend-vitest.png` y `sprint2-leodeguita-vitest.png`. | Secciones 5, 6 y 7 |
| 15. Cierre | Darwin | Gracias y preguntas. La evidencia está en el Anexo A del informe. | Logos de ESPOL y Leodega. | Anexo A |

Notas de Carla:
- En el informe el nombre es **Joao Dorado** (`config/metadata.tex`); en otras partes de este guion aparece "Johao". Hay que usar el mismo en todo el video.
- La versión de PHP del backend desplegado es **8.2** (`backend/Dockerfile` usa `php:8.2-cli`). La versión de PostgreSQL no aparece en el informe, así que no conviene ponerla.
- Las dos cartas de aceptación están firmadas con fecha **2026-11-16** (sección 8, figuras de "Acceptance Forms"). Si una diapositiva muestra la fecha de aceptación, debe ser esa, y vale para los dos sprints.

## Cosas del deck que hay que ajustar para que coincida con el guion

| Diapositiva | Qué cambiar |
|---|---|
| 7 | Corregida: ahora es la matriz 5×5 del informe, con alto riesgo desde 10 y las tres historias HUG-04, HUA-01 y HUE-05 en su celda. |
| 8 | La tabla tiene filas Valid, Invalid y Boundary. Para equivalencia de HUE-05 las filas deberían ser los cuatro grupos. |
| 5 | Las fechas del Sprint 2 (22 oct a 13 nov) y las 8 historias ya se conocen. |
| 9 y 10 | Siguen con placeholders. Se pueden llenar con la guía de casos en vivo y con el mismo paso de revelar de la diapositiva 11. |
| 4 | Los recuadros de pila tecnológica (Frontend, Backend, Database, Deployment) siguen vacíos. |
| 1 | Falta el nombre del equipo. |
