help: ## Print this message
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'
frontend: ## Installing Frontend Component
	@bash frontend.sh
cart: ## Installing Cart Component
	@bash cart.sh
catalogue: ## Installing Catalogue Component
	@bash catalogue.sh
mongodb: ## Installing MongoDB Component
	@bash mongodb.sh
mysql: ## Installing Mysql Component
	@bash mysql.sh
payment: ## Installing Payment Component
	@bash payment.sh
rabbitmq: ## Installing Rabbitmq Component
	@bash rabbitmq.sh
redis: ## Installing Redis Component
	@bash redis.sh
shipping: ## Installing Shipping Component
	@bash shipping.sh
user: ## Installing User Component
	@bash user.sh
databases: ## Installs all Databases
databases: mongodb mysql redis rabbitmq
