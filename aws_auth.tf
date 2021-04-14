resource "local_file" "aws_auth_configmap" {
  content              = local.config_map_aws_auth
  filename             = "${path.root}/config_map_aws_auth.yaml"
  file_permission      = "0644"
}

resource "null_resource" "kubectl" {
  provisioner "local-exec" {
    command = "kubectl apply -f  $filename  --kubeconfig <(echo $KUBECONFIG | base64 --decode)"
    interpreter = ["/bin/bash", "-c"]
environment = {
      KUBECONFIG = base64encode(local.awskubeconfig)
      filename= "${path.root}/config_map_aws_auth.yaml"
  }
}
depends_on = [local_file.aws_auth_configmap,
	      aws_eks_cluster.cluster
	]
}
