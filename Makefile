PROJECT_ID=<GCP_PROJECT_ID>

APP_NAME=multiregion-demo
VERSION=0.1

REGION_US_CENTRAL=us-central1
REGION_EUROPE_WEST=europe-west1
REGION_ASIA=asia-northeast1

IMAGE_PATH=gcr.io/$(PROJECT_ID)/$(APP_NAME):$(VERSION)

.PHONY: all
deploy-all: image deploy-us deploy-europe deploy-asia

image:
	@echo "🎁 Buidling container image for project [$(PROJECT_ID)], service [$(APP_NAME)]"
	gcloud builds submit --tag $(IMAGE_PATH)

deploy-us:
	@echo "🚀 Deploying to $(REGION_US_CENTRAL) region"
	gcloud beta run deploy $(APP_NAME)-$(REGION_US_CENTRAL) \
	--image $(IMAGE_PATH) \
	--platform managed --allow-unauthenticated --region $(REGION_US_CENTRAL) \
	--update-env-vars REGION=$(REGION_US_CENTRAL)

deploy-europe:
	@echo "🚀 Deploying to $(REGION_EUROPE_WEST) region"
	gcloud beta run deploy $(APP_NAME)-$(REGION_EUROPE_WEST) \
	--image $(IMAGE_PATH) \
	--platform managed --allow-unauthenticated --region $(REGION_EUROPE_WEST) \
	--update-env-vars REGION=$(REGION_EUROPE_WEST)

deploy-asia:
	@echo "🚀 Deploying to $(REGION_ASIA) region"
	gcloud beta run deploy $(APP_NAME)-$(REGION_ASIA) \
	--image $(IMAGE_PATH) \
	--platform managed --allow-unauthenticated --region $(REGION_ASIA) \
	--update-env-vars REGION=$(REGION_ASIA)