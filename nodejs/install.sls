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

{%- if nodejs.debug_pkg is defined and nodejs.debug_pkg != 'null' %}
nodejs_debug_package:
  pkg.{{nodejs.debug_pkg_state}}:
    - name: {{ nodejs.debug_pkg }}
    - require:
      - pkg: nodejs_package
{%- endif %}

{%- if nodejs.dev_pkg is defined and nodejs.dev_pkg != 'null' %}
nodejs_dev_package:
  pkg.{{nodejs.dev_pkg_state}}:
    - name: {{ nodejs.dev_pkg }}
    - require:
      - pkg: nodejs_package
{%- endif %}
