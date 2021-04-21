def someFunc() {
	echo 'someFunc: echo from groovy script'
}

def otherFunc() {
	echo 'otherFunc: echo from groovy script'
	echo "otherFunc: ${params.VERSION}"
}

return this;
