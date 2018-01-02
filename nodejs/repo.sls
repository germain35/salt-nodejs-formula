{%- from "nodejs/map.jinja" import nodejs with context %}

{%- set osfamily   = salt['grains.get']('os_family') %}
{%- set os         = salt['grains.get']('os') %}
{%- set osrelease  = salt['grains.get']('osrelease') %}
{%- set oscodename = salt['grains.get']('oscodename') %}

{%- if nodejs.manage_repo %}
  {%- if osfamily == 'Debian' %}
nodejs_apts_pkg:
  pkg.installed:
    - name: apt-transport-https
    - require_in:
      - pkgrepo: nodejs_repo
  {%- endif %}
  
  {%- if 'repo' in nodejs and nodejs.repo is mapping %}
nodejs_repo:
  pkgrepo.managed:
    {%- for k, v in nodejs.repo.iteritems() %}
    - {{k}}: {{v}}
    {%- endfor %}
  {%- endif %}
{%- endif %}

