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

**Diapositiva 1 (portada)**
> Hello, we are [Team name], from ESPOL, Software Engineering II. This is our midterm presentation for Leodega. I am Carla, and I am here with Johao, Geovanny and Darwin.

**Diapositiva 2 (agenda)**
> In eight minutes, we will show our system, how we planned our tests, and three live test cases. We will also share our code quality results.

**Diapositiva 3 (contexto)**
> Our client is Leodega, and the Product Owner is Leonardo Castro. The problem is [one sentence about the problem]. Leodega has a web app and a mobile web app called Leodeguita. It has three kinds of users: [role 1], [role 2] and [role 3].

**Diapositiva 4 (arquitectura)**
> Here are our component and deployment diagrams. [One sentence about each diagram.] The backend is a Laravel API. The web apps use React. The database is PostgreSQL on Railway, and the web apps run on Vercel. We chose them because [reason 1] and [reason 2].

Nota: Laravel, React, PostgreSQL, Railway y Vercel salen del Anexo B. Los motivos de la elección los pone Carla.

**Diapositiva 5 (sprints)**
> We finished two sprints. Sprint 1 ran from October 1 to October 21. The goal was login for web and mobile, and the basic flows: warehouses, moderation, search, booking and simulated payment. The client accepted all 16 stories. Sprint 2 ran from October 22 to November 13. The goal was companies: organizations, invitations, switching context, and reservations for a company. [X of 8 stories accepted.]

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

## Cosas del deck que hay que ajustar para que coincida con el guion

| Diapositiva | Qué cambiar |
|---|---|
| 7 | Corregida: ahora es la matriz 5×5 del informe, con alto riesgo desde 10 y las tres historias HUG-04, HUA-01 y HUE-05 en su celda. |
| 8 | La tabla tiene filas Valid, Invalid y Boundary. Para equivalencia de HUE-05 las filas deberían ser los cuatro grupos. |
| 5 | Las fechas del Sprint 2 (22 oct a 13 nov) y las 8 historias ya se conocen. |
| 9 y 10 | Siguen con placeholders. Se pueden llenar con la guía de casos en vivo y con el mismo paso de revelar de la diapositiva 11. |
| 4 | Los recuadros de pila tecnológica (Frontend, Backend, Database, Deployment) siguen vacíos. |
| 1 | Falta el nombre del equipo. |
