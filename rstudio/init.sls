# -*- coding: utf-8 -*-
# vim: ft=sls

include:
             {%- if grains.os_family in ('MacOS',) %}
  - .desktop
             {%- else %}
  - .server
  - .desktop
             {%- endif %}
