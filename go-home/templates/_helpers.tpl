{{- define "go-home.name" -}}
{{- printf "%s-%s" .Release.Name "go-home" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "go-home.worker.static.name" -}}
{{- printf "%s-%s" .Release.Name "go-home-worker-static" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "go-home.worker.name" -}}
{{- printf "%s-%s" .Release.Name "go-home-worker" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "go-home.master.name" -}}
{{- printf "%s-%s" .Release.Name "go-home-master" | trunc 63 | trimSuffix "-" -}}
{{- end -}}