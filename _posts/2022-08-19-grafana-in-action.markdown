---
layout: post
title:  "Grafana in Action"
date:   2022-08-19 12:30:00 +0800
categories: Tools
---

* Do not remove this line (it will not be displayed)
{:toc}


# 权限管理

Grafana 的权限分为三个等级：Viewer、Editor 和 Admin，Viewer 只能查看 Grafana 已经存在的面板而不能编辑，Editor 可以编辑面板，Admin 则拥有全部权限例如添加数据源、添加插件、增加 API KEY。



# HTTP API

The Grafana backend exposes an HTTP API, which is the same API that is used by the frontend to do everything from saving dashboards, creating users, and updating data sources. See [HTTP API reference](https://grafana.com/docs/grafana/latest/developers/http_api/)



# Alloy

**Grafana Alloy** is an open source OpenTelemetry Collector distribution with built-in Prometheus pipelines and support for **metrics**, **logs**, **traces**, and **profiles**.



refer:

* https://github.com/grafana/alloy
* https://grafana.com/docs/alloy/latest/


**Grafana Alloy** combines the strengths of the leading collectors into one place. Whether observing applications, infrastructure, or both, Grafana Alloy can collect, process, and export telemetry signals to scale and future-proof your observability approach.

Grafana Alloy 是一个现代化、高性能的开源遥测数据收集器，它巧妙地将各种开源可观测性工具的能力整合在一起，帮助你统一收集、处理和转发指标（Metrics）、日志（Logs）、追踪（Traces）和性能分析（Profiles）数据。无论是观察应用程序、基础设施，还是两者兼顾，Grafana Alloy 都能帮助你扩展和未来验证你的可观测性策略。

> Grafana Alloy 的核心价值在于它能统一处理多种可观测性信号，并具备高度的灵活性和扩展性。

![alloy](/assets/images/202508/alloy.png)

> Collect all your telemetry with one product

Choosing the right tools to collect, process, and export telemetry data can be a confusing and costly experience. The broad range of telemetry you need to process and the collectors you choose can vary widely depending on your observability goals. In addition, you face the challenge of addressing the constantly evolving needs of your observability strategy. For example, you may initially only need application observability, but you then discover that you must add infrastructure observability. Many organizations manage and configure multiple collectors to address these challenges, introducing more complexity and potential errors in their obervability strategy.


> All signals, whether application, infrastructure, or both

**Grafana Alloy** has native pipelines for leading telemetry signals, such as `Prometheus` and `OpenTelemetry`, and databases such as `Loki` and `Pyroscope`. This permits **logs**, **metrics**, **traces**, and **even mature support for profiling**.

> Enterprise strength observability

**Grafana Alloy** improves reliability and provides advanced features for Enterprise needs, such as clusters of fleets and balancing workloads. Grafana [Fleet Management](https://grafana.com/docs/grafana-cloud/send-data/fleet-management/) helps you manage multiple Grafana Alloy deployments at scale.


## Q&A

### alloy 采集 OpenTelemetry 指标与通过 SDK 上报指标方式的区别

Grafana Alloy 本质上是一个功能增强的 OpenTelemetry Collector 发行版。它内置了强大的 Prometheus 流水线，并统一支持四大信号。使用 Alloy（作为 OTel Collector）来采集指标，与应用直接通过 OpenTelemetry SDK 上报指标，并非互斥的替代关系，而是互补的协作关系。它们在不同层面发挥作用。

简单来说：

* OpenTelemetry SDK：**集成在应用程序代码中**，负责生成遥测数据（生成 Span、Metric、Log）。
* Grafana Alloy/OTel Collector：**作为独立进程运行在基础设施层**，负责收集、处理、聚合和导出遥测数据（处理、路由 Span、Metric、Log）。

下图清晰地展示了两者在可观测性数据流中的不同角色与协作方式：

![alloy_vs_sdk](/assets/images/202508/alloy_vs_sdk.png)

从上图可以看出，Alloy 的核心优势在于它是一个统一、中心化的智能数据管道。下表详细对比了这两种方式的优势与应用场景：

| `维度` | `通过 SDK 直接上报 (Push)` | `通过 Alloy/Collector 采集 (Pull/Push)` | `分析`
| -- | -- | -- | --
| **对应用的影响** | **有直接影响**。网络波动、后端不可用可能导致应用线程阻塞或资源消耗增加 | **隔离影响**。Alloy 作为缓冲，后端问题不会直接影响应用性能 | Alloy 的优势巨大。它将应用与观测后端解耦，提升了应用的稳定性和性能
| **数据聚合** | 在客户端进行（如 Histogram 聚合），消耗应用资源 | **可在服务端进行**。Alloy 可以接收原始数据并聚合，减轻应用负担 | Alloy 更具灵活性。可以将聚合逻辑从应用转移到基础设施层
| **协议转换** | **有限**。通常只能上报到支持 OTLP 的后端 | **极其强大**。Alloy 可以接收一种协议（如 Prometheus），输出另一种协议（如 InfluxDB），是打通异构系统的桥梁 | Alloy 的杀手级功能。允许你逐步迁移技术栈，无需重写应用
| **部署模式** | 通常是**主动推送（Push）数据** | **支持推和拉（Push & Pull）**。既可以拉取 Prometheus 指标，也可以接收应用的 OTLP 推送 | Alloy 模式更灵活。Pull 模式对于调试和临时抓取非常有用

现代可观测性架构的最佳实践是结合两者，而不是二选一：

1. 在应用程序中：
    + 务必使用 OpenTelemetry SDK 来生成符合标准的遥测数据（Traces, Metrics, Logs）。
    + 配置 SDK，将其 Metrics 数据推送（Push） 到本地的 Alloy/Collector 实例（使用 OTLP 协议），或者暴露一个 `/metrics` 端点供 Alloy 拉取（Pull）。
2. 在基础设施层：
    + 务必使用 Grafana Alloy（或 OTel Collector）作为所有遥测数据的统一接收、处理和转发中心。
    + 让 Alloy 负责：
      - 从应用拉取指标。
      - 接收应用通过 SDK 推送过来的追踪和指标。
      - 采集主机、数据库、中间件等第三方软件的指标。
      - 进行统一的标签管理、过滤、丰富和转换。
      - 将数据可靠地路由到多个后端（如 Prometheus、Loki、Tempo、多个云厂商）。

**Alloy 的优势并不是取代 SDK，而是建立在 SDK 之上，为用户提供一个强大、可靠、灵活的基础设施层数据处理中心**。 它解决了大规模、异构环境下遥测数据管理的运维痛点，是构建企业级可观测性平台的基石组件。因此，**正确的架构是：应用集成 OTel SDK + 基础设施层部署 Grafana Alloy**。



# Refer

* https://grafana.com/docs/grafana/latest/introduction/
* [Grafana 的一些使用技巧](https://zhuanlan.zhihu.com/p/34005738)








