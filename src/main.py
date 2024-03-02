from google.cloud import secretmanager
import os

project_id = os.environ.get('GCP_PROJECT_ID')
secret_id = os.environ.get('GCP_SECRET_ID')
version_id = "latest"
client = secretmanager.SecretManagerServiceClient()
name = f"projects/{project_id}/secrets/{secret_id}/versions/{version_id}"
response = client.access_secret_version(request={"name": name})
return response.payload.data.decode("UTF-8")
print(f"The secret value is: {secret_value}")


secret_value = get_secret_value(project_id, secret_id, version_id)

def my_cloud_function(request):
    project_id = os.environ.get('GCP_PROJECT_ID')
    secret_id = os.environ.get('GCP_SECRET_ID')
#    project_id = "your-project-id"
#    secret_id = "my-secret"
    version_id = "latest"  # or specify a specific version number
    secret_value = get_secret_value(project_id, secret_id, version_id)
    return f"The secret value is: {secret_value}"