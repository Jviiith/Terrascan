package accurics

{{.prefix}}{{.name}}{{.suffix}}[array.id] {
	array := input.aws_instance[_]
	array.config.instance_type == "t2.large"
	array.config.tags == {"Name": "web-server"}
}
