---
layout: home
title: 首页
---

<div class="home-content">

  <section class="home-section home-categories" aria-label="文章分类">
    <h2 class="section-title">文章分类</h2>
    <div class="category-grid">
      {% for category in site.categories %}
        <div class="category-card">
          <h3 class="category-name">{{ category[0] }}</h3>
          <ul class="category-posts">
            {% for post in category[1] %}
              <li><a href="{{ post.url }}">{{ post.title }}</a></li>
            {% endfor %}
          </ul>
        </div>
      {% endfor %}
    </div>
  </section>

  <section class="home-section home-posts" aria-label="文章列表">
    <h2 class="section-title">文章列表</h2>
    {% assign date_format = site.minima.date_format | default: "%Y-%m-%d" %}
    <ul class="post-list">
      {% for post in site.posts %}
        <li class="post-item">
          <span class="post-meta">{{ post.date | date: date_format }}</span>
          <a class="post-link" href="{{ post.url }}">{{ post.title }}</a>
        </li>
      {% endfor %}
    </ul>
  </section>

</div>
