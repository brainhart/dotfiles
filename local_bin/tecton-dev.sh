
export TECTON="/Users/brian/code/source/tecton"
export TECTON_REPO_PATH=$TECTON
export TECTON_REPO=$TECTON
export PATH="$PATH:$HOME/code/source/arcanist/bin"

alias start-mds="cd $TECTON && bazel run //java/com/tecton/metadataservice:metadata_server"
alias start-grpc-gateway="cd $TECTON && bazel run //go/cmd/grpc_gateway:grpc_gateway -- -metadata_service_url=localhost:50051 -allow_CORS=true"
alias cdt="cd $TECTON"

s3_blow_away() {
	aws s3 ls | awk '{print "s3://"$3}' | xargs -n 1 -P 5 aws s3 rm --recursive
}

delete_branch () {
	branch=$(git rev-parse --abbrev-ref HEAD)
	git checkout master
	git branch -D "$branch"
}

delete_release_branches () {
	git branch --list | rg "release" | xargs git branch -D
}

profile () {
	JAVA_HOME='/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home'
	FILE='/tmp/OSW_test.hprof'
	PID=$(jps | grep BazelTestRunner | awk '{print $1}' 2>/dev/null)
	rm "$FILE"
	jcmd $PID GC.heap_dump "$FILE"
	"$JAVA_HOME"/jhat "$FILE"
}

# psql -U tecton -d metadatadb -c 'DELETE from workflows'
