#!/bin/bash
set -e

latest_commit_response_json=$(curl -H "Accept: application/vnd.github+json" -H "Authorization: Bearer ${INPUT_TOKEN}" https://api.github.com/repos/${INPUT_OWNER}/${INPUT_REPO}/git/refs/heads/${INPUT_BRANCH})
echo $latest_commit_response_json

sha=$(echo $latest_commit_response_json | jq -r '.object.sha')
echo "::set-output name=sha::$sha"

latest_commit_info_response_json=$(curl -H "Accept: application/vnd.github+json" -H "Authorization: bearer ${INPUT_TOKEN}" https://api.github.com/repos/${INPUT_OWNER}/${INPUT_REPO}/commits/${sha})
echo $latest_commit_info_response_json

commit_author=$(echo $latest_commit_info_response_json | jq -r '.commit.author.name')
echo "::set-output name=commit_author::$commit_author"

commit_author_email=$(echo $latest_commit_info_response_json | jq -r '.commit.author.email')
echo "::set-output name=commit_author_email::$commit_author_email"

commit_message=$(echo $latest_commit_info_response_json | jq -r '.commit.message')
echo "::set-output name=message::$commit_message"