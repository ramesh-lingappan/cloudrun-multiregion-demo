PROJECT_ID=cloudguru-codelab-1

APP_NAME=multiregion-demo
VERSION=0.1

REGION_US_CENTRAL=us-central1
REGION_EUROPE_WEST=europe-west1
REGION_ASIA=asia-northeast1

IMAGE_PATH=gcr.io/$(PROJECT_ID)/$(APP_NAME):$(VERSION)

deploy-all: image deploy-us deploy-europe deploy-asia
.PHONY: all

image:
	@echo "🎁 Buidling container image for project [$(PROJECT_ID)], service [$(SERVICE)]"
	gcloud builds submit --tag $(IMAGE_PATH)

deploy-us:
	gcloud beta run deploy $(APP_NAME)-$(REGION_US_CENTRAL) \
	--image $(IMAGE_PATH) \
	--platform managed --allow-unauthenticated --region $(REGION_US_CENTRAL) \
	--update-env-vars REGION=$(REGION_US_CENTRAL)

deploy-europe:
	gcloud beta run deploy $(APP_NAME)-$(REGION_EUROPE_WEST) \
	--image $(IMAGE_PATH) \
	--platform managed --allow-unauthenticated --region $(REGION_EUROPE_WEST) \
	--update-env-vars REGION=$(REGION_EUROPE_WEST)

deploy-asia:
	gcloud beta run deploy $(APP_NAME)-$(REGION_ASIA) \
	--image $(IMAGE_PATH) \
	--platform managed --allow-unauthenticated --region $(REGION_ASIA) \
	--update-env-vars REGION=$(REGION_ASIA)


define deploy
	REGION=$(1)
	SERVICE_NAME=$(APP_NAME)-$(1)
	@echo "🎁 Deploying to [$(SERVICE_NAME)]"
endef 