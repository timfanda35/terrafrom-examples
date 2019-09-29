# Exmaple - Cloudbuild

## Set the environment variables

```
PROJECT_ID=$(gcloud config get-value core/project)
PROJECT_NUMBER=$(gcloud projects list --filter="$PROJECT_ID" --format="value(PROJECT_NUMBER)")
GCB_SERVICE_ACCOUNT=$PROJECT_NUMBER@cloudbuild.gserviceaccount.com

echo $PROJECT_ID
echo $PROJECT_NUMBER
echo $GCB_SERVICE_ACCOUNT
```

## Enable APIs

```
gcloud services enable compute.googleapis.com
gcloud services enable storage-api.googleapis.com
gcloud services enable cloudbuild.googleapis.com
```

## Add Permission to Cloudbuild service account

```
gcloud projects add-iam-policy-binding $PROJECT_ID \
 --member=serviceAccount:$GCB_SERVICE_ACCOUNT \
 --role=roles/compute.instanceAdmin.v1

gcloud projects add-iam-policy-binding $PROJECT_ID \
 --member=serviceAccount:$GCB_SERVICE_ACCOUNT \
 --role=roles/iam.serviceAccountUser

gcloud projects add-iam-policy-binding $PROJECT_ID \
 --member=serviceAccount:$GCB_SERVICE_ACCOUNT \
 --role=roles/storage.admin
```

## Create GCE bucket for storing Terraform state

```
gsutil mb gs://$PROJECT_ID
```

## Submit builds

```
gcloud builds submit
```

## Check result

```
gcloud compute instances list
```

## Clean

Comment the instance definition in `main.tf`, and run

```
gcloud builds submit
```
