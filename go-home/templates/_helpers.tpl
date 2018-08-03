{{- define "go-home.name" -}}
{{- default .Chart.Name "go-home" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "go-home.worker.static.name" -}}
{{- default .Chart.Name "go-home-worker-static" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "go-home.worker.name" -}}
{{- default .Chart.Name "go-home-worker" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{- define "go-home.master.name" -}}
{{- default .Chart.Name "go-home-master" | trunc 63 | trimSuffix "-" -}}
{{- end -}}