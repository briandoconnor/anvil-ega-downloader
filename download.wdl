version 1.0

task download {

input {
  String fileid
  String fileType
  File token
}

command {
  pyega3 -d -cf ${token} fetch ${fileid}
}

output {
  Array[File] outputfile = glob("${fileid}/*.${fileType}")
}

runtime {
 docker: "quay.io/biocontainers/pyega3:3.4.0--py_0"
 cpu: 1
 memory: "512 MB"
 disks: "local-disk 375 SSD"
}
}

workflow ega_download {

input {
  String fileid
  String fileType
  File token
}

call download { input: fileid=fileid, fileType=fileType, token=token  }

output {
  File outputfile = download.outputfile[0]
}

}
