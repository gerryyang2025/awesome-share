---
layout: post
title:  "Vue.js in Action"
date:   2025-08-18 12:30:00 +0800
categories: Web
tags:
  - Vue.js
  - Web

---

* Do not remove this line (it will not be displayed)
{:toc}

# 预备知识

假设你对 HTML、CSS 和 JavaScript 已经基本熟悉。如果你对前端开发完全陌生，最好不要直接从一个框架开始进行入门学习，最好是掌握了基础知识再回到这里。你可以通过这篇 [JavaScript 概述](https://developer.mozilla.org/zh-CN/docs/Web/JavaScript/A_re-introduction_to_JavaScript)来检验你的 JavaScript 知识水平。如果之前有其他框架的经验会很有帮助，但也不是必须的。




# Introduction


## What is Vue?

`Vue` (pronounced **/vjuː/**, like `view`) is **a JavaScript framework for building user interfaces**. It builds on top of standard `HTML`, `CSS`, and `JavaScript` and **provides a declarative, component-based programming model** that helps you efficiently develop user interfaces of any complexity.

Here is a minimal example:

{% highlight js %}
import { createApp, ref } from 'vue'

createApp({
  setup() {
    return {
      count: ref(0)
    }
  }
}).mount('#app')
{% endhighlight %}

{% highlight html %}
<div id="app">
  <button @click="count++">
    Count is: {{ count }}
  </button>
</div>
{% endhighlight %}

The above example demonstrates the **two core features** of `Vue`:

* **Declarative Rendering**: Vue extends standard HTML with a template syntax that allows us to declaratively describe HTML output based on JavaScript state.

* **Reactivity**: Vue automatically tracks JavaScript state changes and efficiently updates the DOM when changes happen.

> **Prerequisites**
>
> The rest of the documentation assumes basic familiarity with HTML, CSS, and JavaScript. If you are totally new to frontend development, it might not be the best idea to jump right into a framework as your first step - grasp the basics and then come back! You can check your knowledge level with these overviews for [JavaScript](https://developer.mozilla.org/en-US/docs/Web/JavaScript/A_re-introduction_to_JavaScript), [HTML](https://developer.mozilla.org/en-US/docs/Learn/HTML/Introduction_to_HTML) and [CSS](https://developer.mozilla.org/en-US/docs/Learn/CSS/First_steps) if needed. Prior experience with other frameworks helps, but is not required.


## The Progressive Framework

`Vue` is a framework and ecosystem that covers most of the common features needed in frontend development. But the web is extremely diverse - the things we build on the web may vary drastically in form and scale. With that in mind, Vue is designed to be flexible and incrementally adoptable. Depending on your use case, Vue can be used in different ways:

* Enhancing static HTML without a build step
* Embedding as Web Components on any page
* Single-Page Application (SPA)
* Fullstack / Server-Side Rendering (SSR)
* Jamstack / Static Site Generation (SSG)
* Targeting desktop, mobile, WebGL, and even the terminal

If you find these concepts intimidating, don't worry! The tutorial and guide only require basic `HTML` and `JavaScript` knowledge, and you should be able to follow along without being an expert in any of these.

If you are an experienced developer interested in how to best integrate Vue into your stack, or you are curious about what these terms mean, we discuss them in more detail in [Ways of Using Vue](https://vuejs.org/guide/extras/ways-of-using-vue).

Despite the flexibility, the core knowledge about how Vue works is shared across all these use cases. Even if you are just a beginner now, the knowledge gained along the way will stay useful as you grow to tackle more ambitious goals in the future. If you are a veteran, you can pick the optimal way to leverage Vue based on the problems you are trying to solve, while retaining the same productivity. **This is why we call Vue "The Progressive Framework": it's a framework that can grow with you and adapt to your needs**.



## Single-File Components

In most build-tool-enabled Vue projects, we author Vue components using an HTML-like file format called **Single-File Component** (also known as `*.vue` files, abbreviated as **SFC**). A Vue SFC, as the name suggests, encapsulates the component's **logic** (`JavaScript`), **template** (`HTML`), and **styles** (`CSS`) in a single file. Here's the previous example, written in **SFC format**:

{% highlight vue %}
<script setup>
import { ref } from 'vue'
const count = ref(0)
</script>

<template>
  <button @click="count++">Count is: {{ count }}</button>
</template>

<style scoped>
button {
  font-weight: bold;
}
</style>
{% endhighlight %}

[测试代码](https://play.vuejs.org/#eNp9Uc1OAjEQfpWmFzQgmOgJF6ISDnpQox57gd3ZpdBtm3YKmM2+u9MuIAfDrfP99Zu24U/WDrcB+JhnPnfSIvOAwU6FlrU1DlnDHJSsZaUzNeuRtCd0brRHlpugkU0if3V7LXQ26hLISwNCbdUCgSbGsmVANJo95krmm4ngydvvCz6dpRTpx6xpDpFtm406A5mz0VkSjR5/FDCfGwsFIYfgJt5SGo03O5DVCsdsaVTxIHSbekXPlA84kk+XshquvdG0c7LFNrWVCty7RUmrCU5lIhO5hVJm95owdAEGRzxfQb75B1/7fcQE/3DgwW1B8BOHC1cBdvT86w32dD6RtSmCIvUF8hO8USF27GTPQRdU+0yX2r6kn5O6+vbzPYL2x6Vi0ahsk15w+s3ZhdX/6t4N75OP3pO3v13Gvqs=)

![vue1](/assets/images/202508/vue1.png)

**SFC** is a defining feature of `Vue` and is the recommended way to author Vue components if your use case warrants a build setup. You can learn more about the [how and why of SFC](https://vuejs.org/guide/scaling-up/sfc) in its dedicated section - but for now, just know that Vue will handle all the build tools setup for you.

## API Styles

Vue components can be authored in two different API styles: **Options API** and **Composition API**.

### Options API

With **Options API**, we define a component's logic using an object of options such as `data`, `methods`, and `mounted`. Properties defined by options are exposed on `this` inside functions, which points to the component instance:

{% highlight vue %}
<script>
export default {
  // Properties returned from data() become reactive state
  // and will be exposed on `this`.
  data() {
    return {
      count: 0
    }
  },

  // Methods are functions that mutate state and trigger updates.
  // They can be bound as event handlers in templates.
  methods: {
    increment() {
      this.count++
    }
  },

  // Lifecycle hooks are called at different stages
  // of a component's lifecycle.
  // This function will be called when the component is mounted.
  mounted() {
    console.log(`The initial count is ${this.count}.`)
  }
}
</script>

<template>
  <button @click="increment">Count is: {{ count }}</button>
</template>
{% endhighlight %}

[测试代码](https://play.vuejs.org/#eNp9Us1O3DAQfpWR1QMIlFRqT6sUtUUc4AAIOPqAcWYTs44d2eNl0SrvzjjZZDkgpEjx/Pj7mfFe/Ov7YptQrEQVdTA9XUiHu94HghrXKlmCvXQAZQkBlSazRYikCHOyVqROTqcG4Dql4OYIQPvkaAU/p3jIv+FcugPaOjlG8y4CtYqgSxl0ggblaqBgmgYDpJ5ZMOZbHVLr67iaKYzTATt0dNQAjGZiMVKfnX3NbM0a9bu2CK33mwk592N9xNEszFssrG9Onp9aZC5DRtnJFJgIP/ZHpqF4Ph1JpOOvKpdJckDY9ZYdcARQvSQi7+CvtkZv/kixWJDi4vIAzf72B55hqMrpCl+vygVLnAuKrHFtmuI1esfrG4VLoX3XG4vhrh+HK8UyLSmUtf7tZsxRSMgTmfK6Rb35Iv8adzknxX3AiGGLUiw1UqFBVp3LV4+3uOPzUux8nSx3f1N8QJ5vyhqntv/J1Sz7U9+o9rrLT9G45ile7QhdnE1lofNecze/4ctvrB/l/ip+z6sSwwfUxv9s)


### Composition API

With **Composition API**, we define a component's logic using imported API functions. In SFCs, Composition API is typically used with [`<script setup>`](https://vuejs.org/api/sfc-script-setup). The `setup` attribute is a hint that makes Vue perform compile-time transforms that allow us to use Composition API with less boilerplate. For example, imports and top-level variables / functions declared in `<script setup>` are directly usable in the template.

Here is the same component, with the exact same template, but using Composition API and `<script setup>` instead:

{% highlight vue %}
<script setup>
import { ref, onMounted } from 'vue'

// reactive state
const count = ref(0)

// functions that mutate state and trigger updates
function increment() {
  count.value++
}

// lifecycle hooks
onMounted(() => {
  console.log(`The initial count is ${count.value}.`)
})
</script>

<template>
  <button @click="increment">Count is: {{ count }}</button>
</template>
{% endhighlight %}

[测试代码](https://play.vuejs.org/#eNp9kk9r3DAQxb/KIArZkMUutKfgXdqGHFroH9ocdYgrj73KypKQRtstxt+9I9vr5hByMFjz3hv9NNIgPnpfnBKKW1FFFbQniEjJ76XVvXeBYICA7Rac/eqSJWxghDa4Hq44dSWttGXJjlqRPiFEqgmlVc5GApUDsMv5zdvrxdomy1bWgQ41QZ9yYs5BbRugoLsOAyTfcClKewmAtipgj5Y21zBIC3P/4lSbhDc30o7LDka3qP4qg3Bw7sgdVvQNJ3f7S9hGZ7Awrts8PhyQ22vStVmodYQ3w7MNxuKRTzDyV5XznHhCvCDsvWFQXgFUvxMRk35QRqvjTooVWYr93dL3FoZh2WQcq3KOcLwq115iKygyYKu74ik6y5czMUuhXO+1wfDdTzOUgrtlJWu1Me7Pl6lGIeH2UlcHVMcX6k/xnGtS/AgYMZxQilWjOnTI1Fm+//UNz/y/ir1rkmH3K+JP5OGmzDjbPiXbMPYz30T7eXpi2nYP8f5MaOPlUBk0O8fJLwW/tbtXjv4f913xfsrxXYnxH60a++E=)


### Which to Choose?

Both API styles are fully capable of covering common use cases. They are different interfaces powered by the exact same underlying system. In fact, the **Options API** is implemented on top of the **Composition API**! The fundamental concepts and knowledge about Vue are shared across the two styles.

The **Options API** is centered around the concept of a "component instance" (`this` as seen in the example), which typically aligns better with a class-based mental model for users coming from OOP language backgrounds. It is also more beginner-friendly by abstracting away the reactivity details and enforcing code organization via option groups.

**The Composition API** is centered around declaring reactive state variables directly in a function scope and composing state from multiple functions together to handle complexity. It is more free-form and requires an understanding of how reactivity works in Vue to be used effectively. In return, its flexibility enables more powerful patterns for organizing and reusing logic.

You can learn more about the comparison between the two styles and the potential benefits of Composition API in the [Composition API FAQ](https://vuejs.org/guide/extras/composition-api-faq).


If you are new to Vue, here's our general recommendation:

* For learning purposes, go with the style that looks easier to understand to you. Again, most of the core concepts are shared between the two styles. You can always pick up the other style later.

* For production use:
    + Go with **Options API** if you are not using build tools, or plan to use Vue primarily in low-complexity scenarios, e.g. progressive enhancement.
    + Go with **Composition API + Single-File Components** if you plan to build full applications with Vue.

You don't have to commit to only one style during the learning phase. The rest of the documentation will provide code samples in both styles where applicable, and you can toggle between them at any time using the **API Preference switches** at the top of the left sidebar.


# Quick Start

## Try Vue Online

* To quickly get a taste of Vue, you can try it directly in our [Playground](https://play.vuejs.org/#eNo9jcEKwjAMhl/lt5fpQYfXUQfefAMvvRQbddC1pUuHUPrudg4HIcmXjyRZXEM4zYlEJ+T0iEPgXjn6BB8Zhp46WUZWDjCa9f6w9kAkTtH9CRinV4fmRtZ63H20Ztesqiylphqy3R5UYBqD1UyVAPk+9zkvV1CKbCv9poMLiTEfR2/IXpSoXomqZLtti/IFwVtA9A==).

* If you prefer a plain `HTML` setup without any build steps, you can use this [JSFiddle](https://jsfiddle.net/yyx990803/2ke1ab0z/) as your starting point.

* If you are already familiar with `Node.js` and the concept of build tools, you can also try a complete build setup right within your browser on [StackBlitz](https://vite.new/vue).

* To get a walkthrough of the recommended setup, watch this interactive [Scrimba](http://scrimba.com/links/vue-quickstart) tutorial that shows you how to run, edit, and deploy your first Vue app.


## Creating a Vue Application

**Prerequisites**

1. Familiarity with the command line
2. Install [Node.js](https://nodejs.org/) version `18.3` or higher


In this section we will introduce how to scaffold a Vue [Single Page Application](https://vuejs.org/guide/extras/ways-of-using-vue#single-page-application-spa) on your local machine. The created project will be using a build setup based on [Vite](https://vitejs.dev/) and allow us to use Vue [Single-File Components](https://vuejs.org/guide/scaling-up/sfc) (**SFCs**).

Make sure you have an up-to-date version of `Node.js` installed and your current working directory is the one where you intend to create a project. Run the following command in your command line (without the `$` sign):

{% highlight bash %}
npm create vue@latest
{% endhighlight %}

This command will install and execute [create-vue](https://github.com/vuejs/create-vue), the official Vue project scaffolding tool. You will be presented with prompts for several optional features such as `TypeScript` and testing support:

![vue2](/assets/images/202508/vue2.png)

If you are unsure about an option, simply choose **No** by hitting enter for now. Once the project is created, follow the instructions to install dependencies and start the dev server:

{% highlight bash %}
cd <your-project-name>
npm install
npm run dev
{% endhighlight %}

**You should now have your first Vue project running!** Note that the example components in the generated project are written using the [Composition API](https://vuejs.org/guide/introduction#composition-api) and `<script setup>`, rather than the [Options API](https://vuejs.org/guide/introduction#options-api). **Here are some additional tips**:

* The recommended IDE setup is [Visual Studio Code](https://code.visualstudio.com/) + [Vue - Official extension](https://marketplace.visualstudio.com/items?itemName=Vue.volar). If you use other editors, check out the [IDE support section](https://vuejs.org/guide/scaling-up/tooling#ide-support).

* More tooling details, including integration with backend frameworks, are discussed in the [Tooling Guide](https://vuejs.org/guide/scaling-up/tooling).

* To learn more about the underlying build tool `Vite`, check out the [Vite docs](https://vitejs.dev/).

* If you choose to use `TypeScript`, check out the [TypeScript Usage Guide](https://vuejs.org/guide/typescript/overview).


When you are ready to ship your app to **production**, run the following:

{% highlight bash %}
npm run build
{% endhighlight %}

This will create a production-ready build of your app in the project's `./dist` directory. Check out the [Production Deployment Guide](https://vuejs.org/guide/best-practices/production-deployment.html) to learn more about shipping your app to production.


![vue3](/assets/images/202508/vue3.png)

![vue4](/assets/images/202508/vue4.png)



# Creating a Vue Application

## The application instance

Every **Vue application** starts by **creating a new application instance** with the [createApp](https://vuejs.org/api/application.html#createapp) function:

{% highlight js %}
import { createApp } from 'vue'

const app = createApp({
  /* root component options */
})
{% endhighlight %}

## The Root Component

The object we are passing into `createApp` is in fact a component. Every app requires a "root component" that can contain other components as its children.

If you are using **Single-File Components**, we typically import the root component from another file:

{% highlight js %}
import { createApp } from 'vue'
// import the root component App from a single-file component.
import App from './App.vue'

const app = createApp(App)
{% endhighlight %}

While many examples in this guide only need a single component, **most real applications are organized into a tree of nested, reusable components**. For example, a Todo application's component tree might look like this:

{% highlight text %}
App (root component)
├─ TodoList
│  └─ TodoItem
│     ├─ TodoDeleteButton
│     └─ TodoEditButton
└─ TodoFooter
   ├─ TodoClearButton
   └─ TodoStatistics
{% endhighlight %}

In later sections of the guide, we will discuss how to define and compose multiple components together. **Before that, we will focus on what happens inside a single component**.


## Mounting the App

An application instance won't render anything until its `.mount()` method is called. It expects a "container" argument, which can either be an actual DOM element or a selector string:

{% highlight html %}
<div id="app"></div>
{% endhighlight %}

{% highlight js %}
app.mount('#app')
{% endhighlight %}

The content of the app's root component will be rendered inside the container element. The container element itself is not considered part of the app.

The `.mount()` method should always be called after all app configurations and asset registrations are done. Also note that its return value, unlike the asset registration methods, is the root component instance instead of the application instance.


> In-DOM Root Component Template

The template for the root component is usually part of the component itself, but it is also possible to provide the template separately by writing it directly inside the mount container:

{% highlight html %}
<div id="app">
  <button @click="count++">{{ count }}</button>
</div>
{% endhighlight %}

{% highlight js %}
import { createApp } from 'vue'

const app = createApp({
  data() {
    return {
      count: 0
    }
  }
})

app.mount('#app')
{% endhighlight %}

Vue will automatically use the container's `innerHTML` as the template if the root component does not already have a `template` option.

In-DOM templates are often used in applications that are [using Vue without a build step](https://vuejs.org/guide/quick-start.html#using-vue-from-cdn). They can also be used in conjunction with server-side frameworks, where the root template might be generated dynamically by the server.



## App Configurations

The application instance exposes a `.config` object that allows us to configure a few app-level options, for example, defining an app-level error handler that captures errors from all descendant components:

{% highlight js %}
app.config.errorHandler = (err) => {
  /* handle error */
}
{% endhighlight %}

The application instance also provides a few methods for registering app-scoped assets. For example, registering a component:

{% highlight js %}
app.component('TodoDeleteButton', TodoDeleteButton)
{% endhighlight %}

This makes the `TodoDeleteButton` available for use anywhere in our app. We will discuss registration for components and other types of assets in later sections of the guide. You can also browse the full list of application instance APIs in its [API reference](https://vuejs.org/api/application.html).

Make sure to apply all app configurations before mounting the app!


## Multiple application instances

You are not limited to a single application instance on the same page. The `createApp` API allows multiple Vue applications to co-exist on the same page, each with its own scope for configuration and global assets:

{% highlight js %}
const app1 = createApp({
  /* ... */
})
app1.mount('#container-1')

const app2 = createApp({
  /* ... */
})
app2.mount('#container-2')
{% endhighlight %}

If you are using Vue to enhance server-rendered HTML and only need Vue to control specific parts of a large page, avoid mounting a single Vue application instance on the entire page. Instead, create multiple small application instances and mount them on the elements they are responsible for.








# Refer

* https://vue3js.cn/ (Vue 爱好者)
* https://cn.vuejs.org/ (中文)
* https://vuejs.org/ (英文)
* https://github.com/yyx990803 (Evan You)












