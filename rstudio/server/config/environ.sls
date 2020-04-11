# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}
{%- set sls_package_install = tplroot ~ '.server.package.install' %}

    {%- if 'environ' in rstudio.server and rstudio.server.environ %}
        {%- set sls_package_install = tplroot ~ '.server.package.install' %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

rstudio-server-config-file-managed-environ_file:
  file.managed:
    - name: {{ rstudio.server.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='rstudio-server-config-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ rstudio.rootuser }}
    - group: {{ rstudio.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ rstudio.server.environ|json }}
    - require:
      - sls: {{ sls_package_install }}

    {%- endif %}
