rm -rf ~/git/readme && \
mkdir -p ~/git/readme && \
cd ~/git/readme && \

git clone https://github.com/Macioa/ImmutableStuff && \
git clone https://github.com/Macioa/ImmutableStack && \
git clone https://github.com/Macioa/homebrew-immutable && \

cd ImmutableStuff && npm run fetchMD && \
git add README.md && git commit -m "update readme" && git push && \
cd .. && \

cd ImmutableStack && npm run fetchMD && \
git add README.md && git commit -m "update readme" && git push && \
cd .. && \

cd homebrew-immutable && npm run fetchMD && \
git add README.md && git commit -m "update readme" && git push && \
cd ../.. && \

rm -rf ~/git/readme