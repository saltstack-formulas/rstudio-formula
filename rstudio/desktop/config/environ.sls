# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import rstudio with context %}
{%- set sls_package_install = tplroot ~ '.desktop.package.install' %}

    {%- if 'environ' in rstudio.desktop and rstudio.desktop.environ %}
        {%- set sls_package_install = tplroot ~ '.desktop.package.install' %}
        {%- from tplroot ~ "/libtofs.jinja" import files_switch with context %}

include:
  - {{ sls_package_install }}

rstudio-desktop-config-file-managed-environ_file:
  file.managed:
    - name: {{ rstudio.desktop.environ_file }}
    - source: {{ files_switch(['environ.sh.jinja'],
                              lookup='rstudio-desktop-config-file-managed-environ_file'
                 )
              }}
    - mode: 640
    - user: {{ rstudio.rootuser }}
    - group: {{ rstudio.rootgroup }}
    - makedirs: True
    - template: jinja
    - context:
        config: {{ rstudio.desktop.environ|json }}
    - require:
      - sls: {{ sls_package_install }}

    {%- endif %}
