# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}

include:
             {%- if grains.os_family in ('MacOS',) %}
  - .macapp.clean
             {%- else %}
  - .{{ 'package.clean' if rstudio.server.pkg.use_upstream_packageurl else 'archive.clean' }}
             {%- endif %}
