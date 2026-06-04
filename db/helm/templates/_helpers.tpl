{{/* ****************** */}}
{{/* Define app related */}}
{{/* ****************** */}}

{{- define "app.name" -}}
{{ .Values.app.name }}
{{- end }}

{{- define "app.namespace" -}}
{{ .Values.app.namespace }}
{{- end }}

{{- define "app.tier" -}}
{{ .Values.app.tier }}
{{- end }}

{{- define "app.context" -}}
{{ .Values.app.context }}
{{- end }}

{{- define "app.labels" -}}
app: {{ include "app.name" . }}
tier: {{ include "app.tier" . }}
context: {{ include "app.context" . }}
{{- end }}


{{/* ********************** */}}
{{/* Define service related */}}
{{/* ********************** */}}

{{- define "service.name" -}}
{{ .Values.app.name }}-svc
{{- end }}

{{- define "service.labels" -}}
app: {{ include "service.name" . }}
tier: {{ include "app.tier" . }}
context: {{ include "app.context" . }}
{{- end }}
