{%- from "nodejs/map.jinja" import nodejs with context %}

include:
  - nodejs.repo

nodejs_package:
  pkg.installed:
    - name: {{ nodejs.pkg }}
    - require:
      {%- if nodejs.manage_repo %}
      - sls: nodejs.repo
      {%- endif %}
