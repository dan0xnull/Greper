#install depedencies

wget https://go.dev/dl/go1.19.5.linux-amd64.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf go1.19.5.linux-amd64.tar.gz
mkdir /home/haklog/go
echo "export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc
echo "export PATH=$PATH:/home/haklog/go/bin" >> ~/.bashrc

########################################################################
go install -v github.com/tomnomnom/anew@latest
go install github.com/tomnomnom/waybackurls@latest
go install github.com/lc/gau/v2/cmd/gau@latest
go install -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei@latest
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest
go install -v github.com/hakluke/haktrails@latest
go install github.com/hakluke/hakrawler@latest

