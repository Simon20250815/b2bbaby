# b2bbaby.com — 全面复检报告（覆盖版｜含问题清单+解决方案+合规声明体检）

更新时间：2026-06-01  
站点：https://b2bbaby.com/

> 说明：以下为“内容与呈现层面”的优化建议，不构成法律意见或合规认证结论；涉及目标市场强制法规/标准匹配，请以第三方实验室报告、法规文本与专业合规顾问为准。

---

## 0) 你的最新要求（已纳入本报告）
1. 公司实际成立日期：**2019 年**（本报告将以 2019 为唯一口径给出统一方案）  
2. 首页 H1 使用你选定的版本：  
   **Wholesale Baby Strollers, Safety Gates & Bed Rails — OEM/ODM Manufacturer in China**  
3. 需要我做“合规声明体检”（已在第 3 部分逐页/逐品类列出问题与改法）

---

## 1) 一句话结论
你的网站已经具备不错的 GEO 基础（`llms.txt`、`ai-guidelines`、结构化内容、Shipping Proof），但当前最大的风险集中在：
- **公司成立年份口径冲突（站内仍存在 2010 vs 2019）**
- **合规/认证宣称话术过度绝对化（certified / CPSC certified / CPC certified / ASTM certified / EN certified / CE certified）**
- **robots.txt 仍存在 Cloudflare 段与自定义段并存导致的解析不一致风险**
- 首页仍出现 `GET /@vite/client` 异常请求（工程质量与稳定性信号）

---

## 2) 站点基础（SEO/GEO）问题清单（问题 → 风险 → 解决方案）

### 2.1 公司成立年份与“经验年限”口径冲突（P0）
**发现位置（抽样）：**
- About 页仍写 Founded in **2010**：https://b2bbaby.com/about  
- `llms.txt` 仍写 Founded: **2010**：https://b2bbaby.com/llms.txt  
- `ai-guidelines.md` 仍写 Founded: **2010**：https://b2bbaby.com/ai-guidelines.md  
- 首页卖点写 “Professional manufacturer since **2019**”：https://b2bbaby.com/  

**风险：**
- 生成式引擎会把“实体信息冲突”视为低可信，降低引用/推荐概率（GEO 直接受损）。
- B2B 客户尽调时也会质疑“公司信息不一致”。

**解决方案（以你提供的真实信息为准：2019）：**
1) **全站统一为 Founded: 2019**（About / llms / ai-guidelines / FAQ 公司类等）。  
2) 将 “15+ years experience / 10+ years experience” 改为不与成立年份冲突的表述（推荐两种写法）：
   - 写“团队行业经验”：`10+ years team experience in baby product export manufacturing`  
   - 写“累计出货/批次/客户数”等客观指标（你站内已有：export batches、countries served、units exported）。

---

### 2.2 首页 H1 与英文排版（P1）
**现状：**
- 首页 H1 仍包含不标准词（例如 “Baby bed barrier”）且存在缺空格拼接感（LeadingWholesale / RetailersManufacturer）。

**风险：**
- AI 摘要会直接复用你的标题句子，不专业的词会拉低整站可信度与转化。

**解决方案（你选定的 H1，建议直接替换）：**
> **Wholesale Baby Strollers, Safety Gates & Bed Rails — OEM/ODM Manufacturer in China**

并建议：
- 全面检查首屏文案是否存在“缺空格/拼接”，统一排版。

---

### 2.3 robots.txt 规则并存/潜在冲突（P0）
页面：https://b2bbaby.com/robots.txt

**现状：**
- 文件顶部仍有 Cloudflare Managed robots 段（包含对部分 AI bot 的 Disallow）。
- 你在后面又写了自定义 “AI & Search Engine Friendly Configuration” 段，对同样 bot Allow + crawl-delay。

**风险：**
- 不同爬虫解析策略不同，可能导致 AI 摘要抓取不稳定（你允许 summarization，但 bot 可能被前段拦住）。

**解决方案（推荐从根源解决）：**
1) **优先方案 A（推荐）**：在 Cloudflare 侧关闭/调整 Managed robots 注入，让 robots 只保留你维护的“单一版本”。  
2) 若无法移除 Cloudflare 段：至少确保 Cloudflare 段不要对 GPTBot/ClaudeBot/Google-Extended 等做 Disallow，避免与后文 Allow 冲突。  
3) Content-Signal 建议与你 llms.txt 的立场对齐：明确 `ai-input=yes`（允许用于生成式摘要输入）、`ai-train=no`（禁止训练）。

---

### 2.4 首页出现 `GET /@vite/client` 异常请求（P0）
**现状：**
- 首页网络请求可见 `GET https://b2bbaby.com/@vite/client` 且失败（ERR_ABORTED）。

**风险：**
- 生产环境残留 dev/HMR 探测会影响性能与稳定性信号，间接影响 SEO/GEO。

**解决方案（排查顺序）：**
1) 在构建产物/模板里全局搜索 `@vite/client`，生产环境不应出现引用。  
2) 检查部署流程：确保上线的是 build 产物而不是 dev 相关输出。  
3) 若使用 Astro/Vite：检查是否有插件/脚本在生产环境仍注入 dev client。

---

## 3) 合规声明体检（重点｜逐页/逐产品）

### 3.1 总原则：把“认证/合规”话术从绝对化改成可验证、可交付
你现在站内大量使用 “Certified / XXX certified / CPSC certified / CPC certified / ASTM certified / EN certified / CE certified” 这类表达。  
**对 B2B 买家与生成式引擎来说，这属于高风险话术**：一旦客户追问证据或发现标准错配，会直接损害信任与转化。

**必须牢记的 4 点：**
1) **ASTM/EN 是标准，不是认证机构** → 用 `tested to / compliant with / meets requirements of ...`  
2) **CPSC 是监管机构，不给“认证”** → 用 `meets applicable CPSC requirements`  
3) **CPC 是文件，通常由美国进口商签发** → 你可说 `supports CPC issuance (test reports & documentation provided)`  
4) **CE 是符合性标志（self-declaration），不是“CE certified”** → 用 `CE marking (DoC/technical file available upon request)`

---

### 3.2 全站“建议替换话术模板”（建议你做成统一规范，所有页面复用）

**高风险表达（建议避免） → 推荐表达（更合规也更利于 GEO）**
- “ASTM certified” → “Tested to ASTM F833-23; test reports available upon request.”  
- “EN certified” → “Compliant with EN 1930:2012; third-party test reports available.”  
- “CPSC certified / CPSC standard” → “Meets applicable CPSC requirements; documentation available.”  
- “CPC certified” → “Supports CPC issuance: provide lab test reports & required documentation.”  
- “CE certified” → “CE marking supported (EU compliance documentation available).”

你可以在 FAQ/页脚放一个统一说明（示例）：
> “Standards mentioned (ASTM/EN) refer to applicable test standards. Test reports and compliance documents can be provided upon request. CPC is typically issued by the US importer; we support documentation and test reports.”

---

### 3.3 逐页面/逐品类体检（发现 → 风险点 → 建议改法）

#### A) 首页（合规宣称风险）
页面：https://b2bbaby.com/

**发现：**
- “Certifications: CE / CPC / ISO 9001”  
- “ASTM/EN certified products …”

**风险点：**
- ASTM/EN 用 “certified” 容易被理解为第三方认证。  
- CPC 不是“认证”。  
- CE 不是“认证”，应表达为 CE marking。

**建议改法（示例文案，可直接替换）：**
- “Certifications & Compliance: ISO 9001 certified factory | CE marking supported | Test reports for ASTM/EN standards available | CPC documentation support (upon request)”
- 把 “ASTM/EN certified products” 改为：  
  “Products tested to applicable ASTM/EN standards. Test reports available upon request.”

---

#### B) 产品页：Baby Stroller（折叠婴儿车）
页面：https://b2bbaby.com/products/foldable-baby-stroller-astm

**发现：**
- “ASTM F833-23 & EN 1888 certified”  
- Certifications & Testing：ASTM F833-23 / CPC / EN 1888 / ISO 9001

**风险点：**
- ASTM/EN 不建议写 certified。  
- CPC 建议表达为“支持开具/协助”而非“CPC certified”。  
- ISO 9001 更像体系认证（工厂/管理体系），不应被理解为单个产品认证。

**建议改法：**
- “certified” → “tested to / compliant with ASTM F833-23 and EN 1888”  
- “CPC” → “CPC documentation support (test reports provided)”  
- “ISO 9001” → “ISO 9001 certified factory / quality management system”

---

#### C) 产品页：Safety Gate（安全门）
页面：https://b2bbaby.com/products/en-certified-safety-gate

**发现：**
- “EN 1930 & ASTM F1004 certified”  
- Certifications & Testing：EN 1930 / CPSC / CE / ASTM F1004  
- FAQ： “Meets EN 1930 (EU), ASTM F1004 (US), and CPSC safety standards.”

**风险点：**
- “CPSC standards/ certified”表述不严谨（CPSC 是监管机构）。  
- CE 应表述为 CE marking。

**建议改法：**
- “Certified” → “Compliant with EN 1930:2012 and tested to ASTM F1004; reports available.”  
- “CPSC” → “Meets applicable CPSC requirements for baby safety gates (documentation available).”  
- “CE” → “CE marking (EU compliance documentation available).”

---

#### D) 产品页：High Chair（餐椅）
页面：https://b2bbaby.com/products/cpc-certified-high-chair

**发现：**
- 标题与文案含 “CPC Certified High Chair”  
- Certifications & Testing：CPC / ASTM F404 / FDA / EN 14988  
- 文案含 “FDA & LFGB certified materials”

**风险点：**
- CPC 不建议作为 “Certified”。  
- FDA/LFGB 通常针对材料/食品接触材料，建议明确“材料/部件层面”，避免给人“整机 FDA certified”的误解。

**建议改法：**
- 页面标题建议改为：  
  “High Chair (ASTM F404 / EN 14988 Compliance) — CPC Documentation Support”  
- “FDA & LFGB certified materials” 建议改为：  
  “Food-contact materials can meet FDA / LFGB requirements; supporting test reports available.”

---

#### E) 产品页：Bed Rail（床护栏）— 这是你站内“错配风险最高”的一页
页面：https://b2bbaby.com/products/baby-bed-rail-safety-guard

**发现：**
- “EN 1930 & CPSC certified”  
- Certifications & Testing：EN 1930 / CPSC / **ASTM F1004** / CE

**高风险点（重点）：**
- **ASTM F1004 更常用于安全门/围栏类（gate/enclosure）**，用于 bed rail 很可能是错配风险（除非你确有对应 bed rail 的 F1004 报告且适用范围明确）。  
- “CPSC certified” 不严谨。  
- EN 1930 用于 bed rail 是否适用，需要用你的报告来确认（否则也有错配风险）。

**建议改法（强烈建议“证据→宣称”倒推）：**
1) 先整理 bed rail 的“实际报告清单”：报告名称/标准号/测试机构/日期/适用 SKU。  
2) 页面合规宣称只保留“报告能覆盖的标准”。  
3) 在未确认前，不要写死标准号（尤其是 ASTM F1004）。可用更稳妥的表达：  
   - “Tested to applicable EU/US requirements for bed rails; test reports available upon request.”

---

#### F) About 页（合规宣称呈现方式需重构）
页面：https://b2bbaby.com/about

**发现：**
- Founded 2010（与真实 2019 冲突）  
- Certifications & Audit Reports 里出现：  
  - “CE Marking — EN 71 Certified”  
  - “CPC — ASTM F963 Compliant”  
  - “ASTM F963 US Safety Standard”  

**风险点：**
- EN 71 / ASTM F963 更常见于玩具类（toy safety）。如果你主营是 stroller/gate/chair/bed rail，这会引发“堆砌标准/主营不聚焦/错配”的质疑。  
- CPC 与 ASTM F963 的绑定表达容易误导（CPC 是文件，ASTM F963 是玩具标准）。

**建议改法：**
1) About 的“证书/报告”拆成 3 类更清晰：  
   - 工厂体系：ISO 9001（如有）  
   - 产品测试标准（按品类列出）：Stroller / Gate / High Chair / Bed Rail  
   - 市场合规文件支持：CPC（支持开具/材料提供）、CE marking（DoC/technical file）  
2) 若 EN 71 / ASTM F963 不属于你核心产品线：建议移除；若确实有关联产品，则必须明确对应产品与报告编号，避免泛化。

---

#### G) Shipping Proof（发货记录页：合规话术建议收敛）
页面：https://b2bbaby.com/shipping-proof 及详情页（Los Angeles / Hamburg / Rotterdam / Sydney / New York）

**发现：**
- 详情页存在 “ASTM and EN certified … / EN and CE certified … / ASTM and CPC certified …” 等表达。

**风险点：**
- “certified” 过度绝对化；尤其 “CPC certified” 说法不严谨。

**建议改法：**
- 将 “certified” 改为：  
  “shipped products with compliance documentation / tested to applicable standards”  
- 详情页补一句“证据范围说明”（更利于 GEO）：  
  “Test reports and compliance documents can be provided upon request; client information is redacted.”

---

## 4) 你下一步怎么做（按优先级的落地清单）

### P0（立即做）
1) [ ] 全站 Founded 统一为 **2019**（About / llms / ai-guidelines / 任何公司介绍模块）  
2) [ ] robots.txt 规则收敛成单一、不冲突版本（处理 Cloudflare Managed 段）  
3) [ ] 排查并清除生产环境 `@vite/client` 异常请求  
4) [ ] 全站将 “certified” 类话术替换为 “tested to / compliant with / documentation support” 类表达（按第 3.2 模板）

### P1（尽快做）
5) [ ] 首页 H1 替换为你选定版本，并修复缺空格拼接问题  
6) [ ] Bed Rail 合规标准重新核对：先“拿报告清单”，再写标准号（尤其是 ASTM F1004 的使用）  
7) [ ] About 页 EN71/ASTM F963/CPC 的呈现方式重构：避免“玩具标准”与主品类混写

---

## 5) 本报告抽样依据页面
- 首页：https://b2bbaby.com/  
- robots：https://b2bbaby.com/robots.txt  
- llms：https://b2bbaby.com/llms.txt  
- AI guidelines：https://b2bbaby.com/ai-guidelines.md  
- About：https://b2bbaby.com/about  
- Products：https://b2bbaby.com/products  
- Product（stroller）：https://b2bbaby.com/products/foldable-baby-stroller-astm  
- Product（gate）：https://b2bbaby.com/products/en-certified-safety-gate  
- Product（high chair）：https://b2bbaby.com/products/cpc-certified-high-chair  
- Product（bed rail）：https://b2bbaby.com/products/baby-bed-rail-safety-guard  
- Blog：https://b2bbaby.com/blog  
- Shipping proof：https://b2bbaby.com/shipping-proof  

