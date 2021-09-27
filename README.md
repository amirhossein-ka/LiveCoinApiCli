# LiveCoinApiCli

## a cli interface for [live coin api](https://www.livecoinwatch.com/tools/api) Written in Lua !

### how to use

First, install [Dependencies](#Dependencies) 

clone this repo :

`git clone https://github.com/amirhossein-ka/LiveCoinApiCli.git`

then cd to Directory and run `cli.lua`: `lua cli.lua` or make `cli.lua` executable and run it like this: `./cli.lua`

### Dependencies 

**Note ! You Need Luarocks to install libraries**

*links will be added later*

- [Lua](http://www.lua.org)
- lua-curl
- json
- lummander
- penlight       **depends on lua file system**
- luafilesystem

### Commands 

#### token

First of all, you need to get your api key from [here](https://www.livecoinwatch.com/tools/api)

then set the api key like this:

```bash
./cli.lua token <your-token-here>
```

It will saved in this directory `~/.config/LiveCli/api-key`

if the file exists it will prompt you to overwrite it.

#### status

This command checks the api status

#### credits

it will print the remaining of your daily credits

how to use:

```bash
./cli.lua status
```

it give an error if api-key not set

#### overview

Get current aggregated data for all coins

how to use:

```bash
./cli.lua overview --currency/-c currency
```

if you dont set the currency default will be `BTC`











