# 2SWSG

This project aims to build a suckless Simple Static Web Site Generator.

# Warning

This repo is currently is very early alpha thus it's not yet functionnal.

## What do you mean by `suckless`?

This software is not made to have pretty and fancy features, aka the door to
become a bloated software. It goals is to make build and manage static websites.

Obviously it can have advanced and complex features but will stay logic with
itself. I.e: it won't bundle a spellchecker, visitor's replies, etc.

## What do you mean by `Simple`?

I believe when we want to make a website, we don't have to spend time on how
we have to write correctly tags, tuning CSS, etc. We only have to focus to write
what we want to. Furthermore, HTML is an hideous language, impossible to read
without annoyance for a human. That's why a supported language list is available
`(soon)`.

Another point about simple, is CSS don't watch about id and class but only tag's
name. With that simplicity you can you a simple text parser to generate your
HTML without needing to insert somewhere the correct and cryptic class or id.

And last but not least, we don't have to use shitons of weird javascript snip
somewhere on the Internet to make the website to works. The strict minimal will
be used to ensure it to works (I don't know yet if it will none or a few lines).

## What do you mean by `Static`

There is no backend.

## What do you mean by `Web Site Generator`?

It. Generates. Website.

Nothing else. (Yeah I know, it also manage it. Useful thing to ensure a proper
administration (such as page update, 301 error code))

# How to use it?

The software is cut in multiple config files.

Currently there are no config test so be careful to enter correct values.

## `site.yml`

Contains all the informations about the website. It should never be edited once
the website is generated.

| value            | default                | explanation                                                                                                                              |
| :------          | :--------              | :------------                                                                                                                            |
| site\_name       | My beautiful website   | The name of your website                                                                                                                 |
| site\_domain     | mybeautifulwebsite.org | The domain on which your website is hosted                                                                                               |
| site\_page       | index.html             | The name on which your file will be saved. index.html allows apache/nginx to autoload it without have a trailing `index.html` in URL bar |
| site\_order      | day                    | How your article will be sorted. More info below                                                                                         |
| site\_standalone | false                  | Bundle or not ressources inside the HTML file. `false` is adviced to avoid broken dependencies (if many CSS or so)                       |
| site\_generator  | pandoc                 | Software used to generate the page. More info below                                                                                      |
| site\_date\_sep  | -                      | Date separator. Must be Year Month Day, nothing else is accepted. " character is forbidden                                               |

### order

Allows you to choose how your website will be ordered.

* `plain` : everything in root, a bit messy but meh
* `year` : articles are grouped by year
* `month` : articles are grouped by year then month
* `day ` : articles are grouped by yeah then month then day

Whatever the order choosed, the article will always be in it's own directory
named with article's name (set as metadata).

### generator

Depending on the generator, page's metadata aren't declared to the same place.
You are free to pick the one you want, be just sure to choose a supported one.
If it's isn't supported, feel free to adjust 2swsg or to open an issue.

Currently supported:

* `pandoc`

# Credit

Bash YAML parser: [here](https://github.com/jasperes/bash-yaml)
