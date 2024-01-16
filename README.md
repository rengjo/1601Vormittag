# Learn Terraform - Lambda functions and API Gateway

AWS Lambda functions and API gateway are often used to create serverless
applications.

This repo is a companion repo to the [AWS Lambda functions and API gateway](https://developer.hashicorp.com/terraform/tutorials/aws/lambda-api-gateway) tutorial.

# Terraform AWS Lambda und API Gateway Konfiguration
Dieses Repository enthält Terraform-Konfigurationen zum Erstellen einer AWS Lambda-Funktion und eines API Gateways.

## Dateien im Projekt
- `main.tf`: Dies ist die Hauptkonfigurationsdatei, die den AWS-Provider, die S3-Ressourcen, die Lambda-Funktion und die IAM-Rollen definiert.
- `outputs.tf`: Diese Datei definiert die Ausgaben, die nach dem Ausführen von `terraform apply` angezeigt werden.
- `terraform.tf`: Diese Datei definiert die erforderlichen Terraform- und Provider-Versionen.
- `variables.tf`: Diese Datei definiert die Eingabevariablen, die in der Konfiguration verwendet werden.

## Voraussetzungen
- Installieren Sie Terraform (Version 1.2 oder höher).
- Konfigurieren Sie Ihre AWS-Zugangsdaten. Sie können dies tun, indem Sie die folgenden Umgebungsvariablen setzen:

```bash
export AWS_ACCESS_KEY_ID="Your_AWS_ACCESS_KEY"
export AWS_SECRET_ACCESS_KEY="Your_AWS_SECRET_KEY"
export AWS_SESSION_TOKEN="Your_AWS_SESSION_TOKEN"

Ersetzen Sie Your_AWS_ACCESS_KEY, Your_AWS_SECRET_KEY und Your_AWS_SESSION_TOKEN durch Ihre tatsächlichen AWS-Zugangsdaten.

Verwendung
Führen Sie die folgenden Befehle aus, um die Konfiguration anzuwenden:

terraform init
terraform plan
terraform apply

Fehlerbehebung
Wenn Sie den Fehler No declaration found for "var.region" erhalten, stellen Sie sicher, dass alle Ihre Terraform-Dateien im selben Verzeichnis liegen und dass es keine Tippfehler in den Variablennamen gibt.
