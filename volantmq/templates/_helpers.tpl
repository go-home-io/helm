{{- define "volantmq.name" -}}
{{- default .Chart.Name "volantmq" | trunc 63 | trimSuffix "-" -}}
{{- end -}}
