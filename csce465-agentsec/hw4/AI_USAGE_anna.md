Tool/model and date: GPT-5, 11/17
Purpose: gain familiarity with docker-compose syntax
AI Conversation Log files: file-1.txt
What I used: some of the syntax was initially used for docker-compose.yml, but we decided to go with matt's vrsion of the file in the end
What I changed: different image-name, exclusion of the LLM's additions (such as gateway in network config), inclusion of /app directory, other structural changes
How I tested it: basic exec commands in each of the containers (primarily agent-node)
One error, limitation, or rejected suggestion: the AI used python:3.12-slim for the image, but that image doesn't specify teh debian release and was causing issues. we use python:3.12-slim-trixie for this assignment (though that's not visible in the compose file as it exists now).

Tool/model and date: GPT-5, 11/20
Purpose: fain familiarity with iptables syntax
AI Conversation Log files: file-3.txt
What I used: This was more so used as background knowledge, so I didn't directly use the output
What I changed: Wrote my own iptables commands
How I tested it: Tested via the task 3 tests
One error, limitation, or rejected suggestion: Several options weren't used, for example REJECT was not in the scope of this assignment