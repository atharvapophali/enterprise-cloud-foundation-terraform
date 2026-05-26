package terraform.policies

deny contains "t3.large instances are not allowed" if {
  input.resource_changes[_].type == "aws_instance"
  input.resource_changes[_].change.after.instance_type == "t3.large"
}