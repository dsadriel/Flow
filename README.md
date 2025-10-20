## 🌊 Flow

### 🧭 **Posicionamento**

> “O tempo certo, na cadência certa.”

**Flow** não é um cronômetro: é um espaço onde o usuário *registra, entende e respeita seu ritmo de foco.*
A proposta não é produtividade agressiva, é fluidez.
Cada sessão é uma onda — começa, cresce, quebra, recomeça.

---

### 🎨 **Identidade visual**

**Tom geral:** leve, contínuo, fluido.
Nada de vermelho ou laranja (energia forçada).
Paleta deve refletir **equilíbrio e consistência.**

| Elemento       | Diretriz                           | Exemplo              |
| -------------- | ---------------------------------- | -------------------- |
| **Primária**   | Azul petróleo ou azul acinzentado  | `#2E5EAA`            |
| **Secundária** | Azul-claro translúcido             | `#A3C9F9`            |
| **Acento**     | Lilás discreto para estados ativos | `#C2B8FF`            |
| **Neutros**    | Fundo off-white e cinzas suaves    | `#F8FAFB`, `#D6DAE0` |

**Tipografia:**

* **San Francisco Rounded** (nativo e fluido)
* **Font weight:** médio a semibold, nenhuma bold agressiva.
* Evitar caixa alta. Flow é calmo, não grita.

**Iconografia SF Symbols:**

* Sessão ativa → `waveform.circle.fill`
* Sessão encerrada → `pause.circle.fill`
* Ações → `play.fill`, `plus.circle`, `checkmark.circle`

---

### 🧠 **Tom da marca**

Palavras-chave:

> “Calmo. Intencional. Presente.”

Não é um app de produtividade, é um app de presença mental.
Evite palavras como *meta, tarefa, desempenho*.
Prefira *sessão, ritmo, intervalo, fluxo*.

---

### 🧩 **Arquitetura conceitual**

* Cada **Flow Session** é um objeto com:

  ```swift
  struct FlowSession: Identifiable, Codable {
      let id: UUID
      let start: Date
      let end: Date?
      let duration: TimeInterval
      let note: String?
  }
  ```
* O app incentiva registrar manualmente o início e o fim — sem gamificação.
* Widgets e Live Activity mostram o **Flow atual** (tempo decorrido e “estado”).

---

### 💬 **Microcopy / Linguagem**

| Contexto          | Texto sugerido                               |
| ----------------- | -------------------------------------------- |
| Tela inicial      | “Entre no seu Flow.”                         |
| Botão principal   | “Iniciar sessão” / “Encerrar sessão”         |
| Empty state       | “Nenhuma sessão ainda. Dê o primeiro passo.” |
| Notificação final | “Seu Flow chegou ao fim.”                    |
| Widget            | “Em Flow há 12min.”                          |

---

### ⚙️ **Experiência e comportamento**

* App inicia com um *fade-in* sutil, fundo respirando levemente.
* Botão principal com animação “press and hold” (em vez de tap seco).
* Live Activity:

  * ícone de onda animando suavemente (loop lento).
  * tempo decorrido no canto.
* Widget pequeno: “Flow ativo há X min”.
* Widget médio: histórico das 3 últimas sessões.

---

### 📱 **Pitch rápido (para aula ou portfólio)**

> “Flow é um app minimalista de sessões de foco intencional.
> O usuário inicia, mantém e encerra cada sessão conscientemente.
> O Widget e a Live Activity mantêm a presença desse estado — sem pressa, sem ruído.
> O tempo não é uma contagem regressiva, é uma linha de continuidade.”
