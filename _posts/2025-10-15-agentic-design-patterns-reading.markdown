---
layout: post
title:  "Agentic Design Patterns Reading (智能体设计模式)"
date:   2025-10-15 12:30:00 +0800
categories: ML
tags:
  - Agentic
  - Machine Learning

---

* Do not remove this line (it will not be displayed)
{:toc}

《智能体设计模式》，英文版名称 [Agentic Design Patterns: A Hands-On Guide to Building Intelligent Systems](https://www.amazon.com/Agentic-Design-Patterns-Hands-Intelligent/dp/3032014018/)，作者 [Antonio Gulli](https://www.linkedin.com/in/searchguy/) ，预计 2025 年 12 月由 Springer 出版社出版，原书作者开放在 [Google Docs](https://docs.google.com/document/d/1rsaK53T3Lg5KoGwvf8ukOUvbELRtH-V0LnOIFDxBryE/preview?_bhlid=70327898ebe8f71a831626fa75b6227f78f25e22&tab=t.0) 上。


# 简介

## 前言

在现代人工智能领域，我们见证了从**简单的响应式程序**到**能理解上下文、做出决策并与环境及其他系统动态交互的复杂自主实体**的演变。这些就是**智能体 (Agent)**，以及由它们组成的**智能体系统**。

强大的**大语言模型**（`LLM`）的出现，为理解和生成类人文本及多媒体内容提供了前所未有的能力，成为许多智能体的**认知引擎**。然而，要将这些能力编排成能可靠实现复杂目标的系统，仅靠强大的模型还远远不。我们**还需要结构、设计，以及对智能体如何感知、规划、行动和交互的深思熟虑**。

构建智能系统就像在画布上创作一件复杂的艺术或工程作品。这块画布并非视觉空间，而是**为智能体提供生存和运行环境的底层基础设施与框架**。它是你构建智能应用的基础，**负责管理状态、通信、工具访问和逻辑流程**。

要在这块智能体画布上高效构建，不能只是简单地堆砌组件。你需要理解经过验证的技术 - **模式**。它们能解决智能体行为设计与实现中常见的挑战。正如架构模式指导建筑设计，或设计模式规范软件结构，智能体设计模式为你在画布上赋予智能体生命时遇到的反复问题提供**可复用的解决方案**。

## 什么是智能体系统？

**智能体系统**本质上是一种**计算实体**，能感知其环境（包括数字和物理环境），根据这些感知和预设或学习到的目标做出决策，并自主执行行动以实现目标。**与传统软件严格按照固定步骤执行不同，智能体具备一定的灵活性和主动性**。

假设你需要一个系统来管理客户咨询。传统系统可能只会按照固定脚本操作。而智能体系统则能感知客户问题的细微差别，访问知识库，与其他内部系统（如订单管理）交互，甚至主动提出澄清问题，并预见客户的后续需求。这些智能体在你的应用基础设施画布上运行，利用可用的服务和数据。

智能体系统通常具备如下特性：

1. **自主性**，无需持续人工干预即可行动
2. **主动性**，能主动采取行动实现目标
3. **响应性**，能有效应对环境变化

它们本质上是**目标导向**的，始终致力于实现目标。一个关键能力是**工具使用**，即**能与外部 API、数据库或服务交互，有效地突破自身画布的限制**。它们**拥有记忆**，能在多次交互中保留信息，并能与用户、其
他系统或同一/关联画布上的其他智能体**进行通信**。

**要有效实现这些特性，系统复杂度会显著提升**。智能体如何在画布上跨多步保持状态？如何决定何时、如何使用工具？不同智能体之间的通信如何管理？如何为系统构建弹性以应对意外结果或错误？


## 为什么模式对智能体开发至关重要

正因如此，**智能体设计模式**变得不可或缺。它们不是死板的规则，而是经过实战检验的模板或蓝图，为智能体领域的标准设计与实现挑战提供成熟的解决方案。识别并应用这些设计模式，可以提升你在画布上构建智能体的结构性、可维护性、可靠性和效率。

**使用设计模式能避免你为诸如对话流程管理、外部能力集成或多智能体协作等基础任务重复造轮子**。它们为你的智能体逻辑提供了通用语言和结构，使代码更易于理解和维护。实现专为错误处理或状态管理设计的模式，能直接提升系统的健壮性和可靠性。**借助这些成熟方法，你可以专注于应用的独特创新，而不是智能体行为的底层机制**。

**本书提炼了 21 个关设计模式，作为在不同技术画布上构建复杂智能体的基础模块和技术**。理解并应用这些模式，将极大提升你设计和实现智能系统的能力。


## 框架简介

为了让代码示例有具体的“画布”（详见附录），本书主要采用**三大主流智能体开发框架**。`LangChain` 及其有状态扩展 `LangGraph`，为串联语言模型与其他组件提供了灵活方式，是构建复杂操作序列和流程图的强大画布。`Crew AI` 专为多智能体、角色和任务编排设计，适合协作型智能体系统。`Google Agent Developer Kit`（Google ADK） 则提供了智能体构建、评估和部署的工具与组件，是集成 Google AI 基础设施的有力画布。

这些框架代表了智能体开发画布的不同侧面，各有优势。通过跨工具示例，你将更全面理解模式在不同技术环境下的应用。所有示例都聚焦于模式核心逻辑和实际落地，强调清晰与实用。

读完本书，你不仅能掌握 21 个核心智能体模式背后的基本原理，还能获得丰富的实战经验和代码示例，助你在所选开发画布上高效构建更智能、更强大、更自主的系统。让我们开启这场实战之旅吧！


## 智能体的特征

简单来说，**智能体**是一种能够感知环境并采取行动以实现特定目标的系统。它是从传统大语言模型（LLM）演化而来，具备规划、工具使用和环境交互等能力。可以把智能体 AI 想象成一个能在工作中不断学习的智能助手。它遵循一个简单的**五步循环**来完成任务：

1. **获取任务目标**：你给它一个目标，比如“帮我安排日程”。
2. **扫描环境信息**：它会收集所有必要的信息——阅读邮件、检查日历、访问联系人——以了解当前状况。
3. **制定计划**：它会思考并制定实现目标的最佳方案。
4. **执行行动**：它会发送邀请、安排会议、更新你的日历来落实计划。
5. **学习与优化**：它会观察结果并不断调整。例如，如果会议被重新安排，系统会从中学习以提升未来表现。


短短两年间，**AI 范式**发生了巨大转变，从**简单自动化**迈向**复杂自主系统**。最初，工作流依赖基础提示和触发器，利用 LLM 处理数据。随后，检索增强生成（RAG）技术出现，通过事实信息提升模型可靠性。接着，单体智能体诞生，能够调用多种工具。如今，我们正步入智能体 AI 时代，多个专业智能体协作完成复杂目标，AI 的协同能力实现了质的飞跃。

本书旨在探讨专业智能体如何协作、互动以实现复杂目标的设计模式，**每一章都将展示一种协作与交互范式**。

本质上，智能体是从传统模型跃升而来的自主系统，能够感知、规划并行动以实现特定目标。技术演进正从单一工具型智能体迈向复杂协作型多智能体系统，能够应对多维任务。未来，通才型、个性化甚至具身化智能体将成为经济参与者。持续发展预示着向自我优化、目标驱动系统的重大转变，这类系统有望自动化整个工作流，彻底重塑我们与技术的关系。


# 模式1：提示链（Prompt Chaining）

## 提示链模式概述

**提示链**（Prompt Chaining），有时也称为**流水线**（Pipeline）模式，是在使用大型语言模型（LLM）时处理复杂任务的强大范式。**与其让 LLM 一步到位解决复杂问题，提示链主张采用分而治之策略，将原本棘手的问题拆解为一系列更小、更易管理的子问题**。每个子问题通过专门设计的提示单独处理，并将前一步的输出作为下一步的输入，形成链式依赖。

这种顺序处理技术为与 LLM 的交互带来了模块化和清晰性。通过拆解复杂任务，可以更容易理解和调试每个步骤，使整体流程更健壮、更易解释。每一步都可针对问题的某一方面精细优化，提升输出的准确性和针对性。

每一步的输出作为下一步的输入至关重要。这种信息传递建立了依赖链，前序操作的上下文和结果会引导后续处理，使 LLM 能够在前一步基础上不断完善理解，逐步逼近目标解。

此外，提示链不仅仅是拆解问题，还能集成外部知识和工具。每一步都可以指示 LLM 与外部系统、API 或数据库交互，扩展其知识和能力。这极大提升了 LLM 的潜力，使其不仅是孤立模型，更是智能系统的核心组件。

**提示链的意义远超简单问题求解，它是构建复杂智能体的基础技术**。这些智能体可利用提示链自主规划、推理和行动，适应动态环境。通过合理设计提示序列，智能体可完成多步推理、规划和决策任务，模拟人类思维流程，实现更自然、高效的复杂领域交互。

## 实战代码示例


提示链实现方式包括脚本中的顺序函数调用，也可用专门框架管理流程、状态和组件集成。LangChain、LangGraph、Crew AI、Google Agent Development Kit（ADK）等框架为多步流程构建和执行提供了结构化环境，适合复杂架构。

以 LangChain 和 LangGraph 为例，其核心 API 专为链式和图式操作设计。LangChain 提供线性序列抽象，LangGraph 支持有状态和循环计算，适合更复杂的智能体行为。以下示例聚焦基础线性序列。

代码实现了两步提示链，作为数据处理流水线。第一步解析非结构化文本并提取信息，第二步将提取结果转为结构化数据格式。

提示链示例代码：https://colab.research.google.com/drive/15XCzDOvBhIQaZ__xkvruf5sP9OznAbK9

```python
import os
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser

# For better security, load environment variables from a .env file
# from dotenv import load_dotenv
# load_dotenv()
# Make sure your OPENAI_API_KEY is set in the .env file

# Initialize the Language Model (using ChatOpenAI is recommended)
llm = ChatOpenAI(temperature=0)

# --- Prompt 1: Extract Information ---
prompt_extract = ChatPromptTemplate.from_template(
    "Extract the technical specifications from the following text:\n\n{text_input}"
)

# --- Prompt 2: Transform to JSON ---
prompt_transform = ChatPromptTemplate.from_template(
    "Transform the following specifications into a JSON object with 'cpu', 'memory', and 'storage' as keys:\n\n{specifications}"
)

# --- Build the Chain using LCEL ---
# The StrOutputParser() converts the LLM's message output to a simple string.
extraction_chain = prompt_extract | llm | StrOutputParser()

# The full chain passes the output of the extraction chain into the 'specifications'
# variable for the transformation prompt.
full_chain = (
    {"specifications": extraction_chain}
    | prompt_transform
    | llm
    | StrOutputParser()
)

# --- Run the Chain ---
input_text = "The new laptop model features a 3.5 GHz octa-core processor, 16GB of RAM, and a 1TB NVMe SSD."

# Execute the chain with the input text dictionary.
final_result = full_chain.invoke({"text_input": input_text})

print("\n--- Final JSON Output ---")
print(final_result)
```


此 Python 代码演示了如何用 LangChain 处理文本。分两步提示：先从输入字符串提取技术规格，再将规格转为 JSON。用 ChatOpenAI 进行模型交互，StrOutputParser 保证输出为可用字符串。**LangChain 表达式语言（LCEL）优雅地将提示和模型串联**。extraction_chain 负责提取规格，full_chain 用提取结果作为转换提示输入。示例输入为笔记本参数，full_chain 依次处理，最终输出 JSON 字符串。


## 上下文工程与提示工程

**上下文工程**是一种系统性方法，旨在于 AI 生成前为模型构建完整的信息环境。**该方法认为，模型输出质量更多取决于所提供的丰富上下文，而非模型架构本身**。

![agent1](/assets/images/202510/agent1.png)

上下文工程是传统提示工程的升级，后者仅优化用户即时问题的表达。上下文工程扩展至多层信息，包括系统提示（如“你是技术写手，语气需正式且精确”），还可加入外部数据，如检索文档（AI 主动从知识库获取信息）、工具输出（如调用 API 查询日程），以及用户身份、历史交互、环境状态等隐性数据。即使模型再先进，若上下文有限或构建不当，性能也会受限。

## 关键要点

* 提示链将复杂任务拆解为一系列小型、聚焦步骤，亦称流水线模式。
* 每步链条包含一次 LLM 调用或处理逻辑，以上一步输出为输入。
* 该模式提升了与语言模型复杂交互的可靠性和可管理性。
* LangChain/LangGraph、Google ADK 等框架为多步序列定义、管理和执行提供了强大工具。

## 总结

通过将复杂问题拆解为一系列更简单、易管理的子任务，提示链为引导大型语言模型提供了稳健框架。分而治之策略让模型每次专注于单一操作，显著提升输出的可靠性和可控性。作为基础模式，它支持构建具备多步推理、工具集成和状态管理能力的高级智能体。掌握提示链，是打造具备复杂流程执行能力、上下文感知系统的关键。

## 参考文献

* [LangChain LCEL 文档 - python.langchain.com](https://python.langchain.com/v0.2/docs/core_modules/expression_language/)
* [LangGraph 文档 - langchain-ai.github.io](https://langchain-ai.github.io/langgraph/)
* [Prompt Engineering Guide: Chaining Prompts - promptingguide.ai](https://www.promptingguide.ai/techniques/chaining)
* [OpenAI API 文档：通用提示概念 - platform.openai.com](https://platform.openai.com/docs/guides/gpt/prompting)
* [Crew AI 文档：任务与流程 - docs.crewai.com](https://docs.crewai.com/)
* [Google AI 开发者提示指南 - cloud.google.com](https://cloud.google.com/discover/what-is-prompt-engineering?hl=zh-cn)
* [Vertex Prompt Optimizer - cloud.google.com](https://cloud.google.com/vertex-ai/generative-ai/docs/learn/prompts/prompt-optimizer)


# 模式2：路由

## 路由模式概述

虽然通过提示链实现的顺序处理是利用语言模型执行确定性、线性工作流的基础技术，但在需要自适应响应的场景下，其适用性有限。现实中的智能体系统通常需要根据环境状态、用户输入或前序操作结果等因素，在多个潜在动作之间进行仲裁。这种动态决策能力——即根据特定条件将控制流导向不同的专用函数、工具或子流程——就是通过“路由”机制实现的。

路由为智能体的操作框架引入了条件逻辑，使其从固定执行路径转变为动态评估特定标准、从一组可能的后续动作中进行选择的模式，从而实现更灵活、具备上下文感知的系统行为。

**路由机制可在智能体操作周期的多个阶段实现：既可用于初始任务分类，也可在处理链中间决定后续动作，或在子流程中选择最合适的工具**。

LangChain 、 LangGraph 和 Google 的 Agent Developer Kit (ADK) 等计算框架提供了定义和管理此类条件逻辑的显式结构。LangGraph 以其基于状态的图架构，尤其适合需要根据系统累积状态进行决策的复杂路由场景。Google ADK 则为智能体能力和交互模型的结构化提供基础组件，便于实现路由逻辑。在这些框架的执行环境中，开发者定义可能的操作路径，以及决定节点间转换的函数或模型评估。

**路由的实现使系统超越了确定性顺序处理，能够开发出更具适应性的执行流，动态响应更广泛的输入和状态变化**。

## 实战代码示例

代码实现路由需定义可能路径及决策逻辑。LangChain 和 LangGraph 等框架提供了专用组件和结构，LangGraph 的状态图结构尤其适合路由逻辑的可视化和实现。

以下代码演示了使用 LangChain 和 Google 生成式 AI 构建的简单智能体系统。系统设置一个“协调者”，根据请求意图（预订、信息、或不明确）将用户请求路由到不同的“子智能体”处理器。系统利用语言模型分类请求，并委托给相应处理函数，模拟多智能体架构中的基本委托模式。

路由示例代码：https://colab.research.google.com/drive/1Yh3eUcvajJfgTFKhEQga6bJ3yyKodAmg

```python
# Copyright (c) 2025 Marco Fago
#
# This code is licensed under the MIT License.
# See the LICENSE file in the repository for the full license text.

from langchain_google_genai import ChatGoogleGenerativeAI
from langchain_core.prompts import ChatPromptTemplate
from langchain_core.output_parsers import StrOutputParser
from langchain_core.runnables import RunnablePassthrough, RunnableBranch

# --- Configuration ---
# Ensure your API key environment variable is set (e.g., GOOGLE_API_KEY)
try:
    llm = ChatGoogleGenerativeAI(model="gemini-2.5-flash", temperature=0)
    print(f"Language model initialized: {llm.model}")
except Exception as e:
    print(f"Error initializing language model: {e}")
    llm = None

# --- Define Simulated Sub-Agent Handlers (equivalent to ADK sub_agents) ---

def booking_handler(request: str) -> str:
    """Simulates the Booking Agent handling a request."""
    print("\n--- DELEGATING TO BOOKING HANDLER ---")
    return f"Booking Handler processed request: '{request}'. Result: Simulated booking action."

def info_handler(request: str) -> str:
    """Simulates the Info Agent handling a request."""
    print("\n--- DELEGATING TO INFO HANDLER ---")
    return f"Info Handler processed request: '{request}'. Result: Simulated information retrieval."

def unclear_handler(request: str) -> str:
    """Handles requests that couldn't be delegated."""
    print("\n--- HANDLING UNCLEAR REQUEST ---")
    return f"Coordinator could not delegate request: '{request}'. Please clarify."

# --- Define Coordinator Router Chain (equivalent to ADK coordinator's instruction) ---
# This chain decides which handler to delegate to.
coordinator_router_prompt = ChatPromptTemplate.from_messages([
    ("system", """Analyze the user's request and determine which specialist handler should process it.
     - If the request is related to booking flights or hotels, output 'booker'.
     - For all other general information questions, output 'info'.
     - If the request is unclear or doesn't fit either category, output 'unclear'.
     ONLY output one word: 'booker', 'info', or 'unclear'."""),
    ("user", "{request}")
])

if llm:
    coordinator_router_chain = coordinator_router_prompt | llm | StrOutputParser()

# --- Define the Delegation Logic (equivalent to ADK's Auto-Flow based on sub_agents) ---
# Use RunnableBranch to route based on the router chain's output.

# Define the branches for the RunnableBranch
branches = {
    "booker": RunnablePassthrough.assign(output=lambda x: booking_handler(x['request']['request'])),
    "info": RunnablePassthrough.assign(output=lambda x: info_handler(x['request']['request'])),
    "unclear": RunnablePassthrough.assign(output=lambda x: unclear_handler(x['request']['request'])),
}

# Create the RunnableBranch. It takes the output of the router chain
# and routes the original input ('request') to the corresponding handler.
delegation_branch = RunnableBranch(
    (lambda x: x['decision'].strip() == 'booker', branches["booker"]), # Added .strip()
    (lambda x: x['decision'].strip() == 'info', branches["info"]),     # Added .strip()
    branches["unclear"] # Default branch for 'unclear' or any other output
)

# Combine the router chain and the delegation branch into a single runnable
# The router chain's output ('decision') is passed along with the original input ('request')
# to the delegation_branch.
coordinator_agent = {
    "decision": coordinator_router_chain,
    "request": RunnablePassthrough()
} | delegation_branch | (lambda x: x['output']) # Extract the final output

# --- Example Usage ---
def main():
    if not llm:
        print("\nSkipping execution due to LLM initialization failure.")
        return

    print("--- Running with a booking request ---")
    request_a = "Book me a flight to London."
    result_a = coordinator_agent.invoke({"request": request_a})
    print(f"Final Result A: {result_a}")

    print("\n--- Running with an info request ---")
    request_b = "What is the capital of Italy?"
    result_b = coordinator_agent.invoke({"request": request_b})
    print(f"Final Result B: {result_b}")

    print("\n--- Running with an unclear request ---")
    request_c = "Tell me about quantum physics."
    result_c = coordinator_agent.invoke({"request": request_c})
    print(f"Final Result C: {result_c}")

if __name__ == "__main__":
    main()
```


如上，Python 代码利用 LangChain 和 Google 生成式 AI（gemini-2.5-flash）构建了一个简单智能体系统。定义了 `booking_handler`、`info_handler`、`unclear_handler` 三个模拟子智能体处理器，分别处理不同类型请求。

核心组件 `coordinator_router_chain` 通过 `ChatPromptTemplate` 指示语言模型将用户请求分类为 `booker`、`info` 或 `unclear`。`RunnableBranch` `根据分类结果将原始请求委托给对应处理函数。coordinator_agent` 组合上述组件，先路由请求，再交由选定处理器，最终输出处理结果。

`main` 函数演示了三种请求的处理流程，展示了不同输入如何被路由和处理。代码包含语言模型初始化错误处理，结构模拟了多智能体框架中协调者根据意图委托任务的模式。


## 关键要点

* 路由使智能体可根据条件动态决策下一步流程。
* 智能体可处理多样输入并自适应行为，突破线性执行限制。
* 路由逻辑可用 LLM、规则系统或嵌入相似度实现。
* LangGraph、Google ADK 等框架提供结构化路由定义与管理方式，架构风格各异。


## 总结

路由模式是构建真正动态、响应式智能体系统的关键一步。通过实现路由，智能体不仅能超越简单线性流程，还能智能决策如何处理信息、响应用户输入、调用工具或子智能体。

路由可应用于客服机器人、复杂数据处理流程等多领域。分析输入并有条件地引导工作流，是应对真实任务多样性的基础。

LangChain 和 Google ADK 的代码示例展示了两种有效的路由实现方式。LangGraph 的图结构适合复杂多步流程的显式状态与转换定义，Google ADK 则侧重能力（工具）定义，由框架自动路由，适合动作明确的智能体。

掌握路由模式，是打造能智能应对不同场景、根据上下文提供定制响应或动作的智能体应用的核心能力。


# 模式3：并行化

## 并行化模式概述

我们已经介绍了用于顺序流程的提示链（Prompt Chaining），以及用于动态决策和路径切换的路由（Routing）。虽然这些模式非常重要，但许多复杂的智能体任务其实包含多个可以同时执行的子任务，而不是一个接一个地串行处理。这时，**并行化设计模式**就变得至关重要。

**并行化指的是同时执行多个组件**，比如 LLM 调用、工具使用，甚至整个子智能体。**与等待上一步完成再开始下一步不同，并行执行允许独立任务同时运行，大幅缩短可拆分为独立部分的任务的整体执行时间**。

举例来说，一个用于研究某主题并总结结果的智能体串行流程可能是：

1. 搜索来源 A
2. 总结来源 A
3. 搜索来源 B
4. 总结来源 B
5. 综合 A 和 B 的摘要，生成最终答案

而并行流程则可以：

1. 同时搜索来源 A 和 来源 B
2. 两个搜索完成后，同时总结来源 A 和 来源 B
3. 综合 A 和 B 的摘要（这一步通常是串行的，需等待并行步骤完成）

核心思想是识别流程中彼此无依赖的部分，并将它们并行执行。尤其在涉及外部服务（如 API 或数据库）有延迟时，可以同时发起多个请求，显著提升效率。

**实现并行化通常需要支持异步执行或多线程/多进程的框架**。现代智能体框架普遍支持异步操作，允许你轻松定义可并行运行的步骤。

**LangChain、LangGraph 和 Google ADK 等框架都提供了并行执行机制**。在 LangChain Expression Language（LCEL）中，可以通过将多个 runnable 对象组合（如 `|` 用于串行，结构化链或图分支用于并行）实现并行执行。LangGraph 通过图结构，允许你定义多个节点在同一状态转换下并发执行，实现流程的并行分支。Google ADK 则原生支持智能体并行执行，极大提升多智能体系统的效率和可扩展性。ADK 框架内置的并行能力让开发者可以设计多个智能体同时运行的解决方案，而非串行处理。

**并行化模式**对于提升智能体系统的效率和响应速度至关重要，尤其适用于涉及多个独立查找、计算或外部服务交互的任务，是优化复杂智能体工作流性能的关键技术。


## 总结

**并行化模式**是一种通过同时执行独立子任务优化计算流程的方法，尤其适用于涉及多次模型推理或外部服务调用的复杂操作，可有效降低整体延迟。

各框架实现机制不同：LangChain 用 `RunnableParallel` 明确定义并行处理链；Google ADK 则可通过多智能体委托，由主协调模型分派子任务并并发执行。

将并行处理与串行（链式）和条件（路由）控制流结合，可构建高性能、复杂任务管理能力强的智能体系统。


# 模式4：反思（Reflection）

## 反思模式概述

我们已经探讨了基础的智能体模式：链式执行（Chaining）、路径选择（Routing）和并行化（Parallelization）。这些模式让智能体能够更高效、更灵活地完成复杂任务。然而，即使拥有复杂的工作流，智能体的初始输出或计划也可能并不理想、准确或完整。这时，**反思（Reflection）模式**就发挥了作用。

**反思模式指的是智能体对自身的工作、输出或内部状态进行评估，并利用评估结果来提升性能或优化响应**。这是一种自我纠错或自我改进机制，使智能体能够根据反馈、内部批判或与目标标准的对比，反复优化输出或调整策略。反思有时也可以由专门负责分析初始智能体输出的独立智能体来实现。









# Refer

* 中文版在线阅读：https://jimmysong.io/book/agentic-design-patterns/
* 《智能体设计模式》中文版 PDF 下载地址：https://cloud.umami.is/q/4bIjfLq8D
* 代码示例：https://drive.google.com/drive/u/0/folders/1Y3U3IrYCiJ3E45Z8okR5eCg7OPnWQtPV