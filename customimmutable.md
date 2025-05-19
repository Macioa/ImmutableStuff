# Customizing The Immutable Stack

The Immutable Stack is designed for transparency and customization.

## 1. Create a custom code base
Clone Immutable and Immutable-homebrew repositories. 
```
git clone https://github.com/Macioa/ImmutableStack && \
git clone https://github.com/Macioa/homebrew-immutable

```
## 2. Create or update generators
Alter Immatable source code directly or generate literals from existing code with
```
immutable -gentemplate my_entity my_folder/myfile.ex
```
## 4. Package source and move to homebrew-immutable
From Immutable Source root
```
cd ImmutableStack && \
npm install && npm run build && \
cd .build && tar -czvf CustomImmutableStack.tar.gz -C . . && \
mv CustomImmutableStack.tar.gz ../homebrew-immutable
```
## 5. Update homebrew-immutable/immutable.rb declaration
Change source url and remove sha256
```ruby
    url "file://#{File.expand_path("CustomImmutableStack.tar.gz", __dir__)}"
    # sha256 "88b621cffba66e524a54dfa21b890e36f39acf9f39c5f2c8b9f6f68df23c8048"
```
## 6. Reinstall Immutable
```
cd homebrew-immutable && \
brew reinstall --build-from-source immutable.rb
```