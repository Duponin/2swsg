# 2SWSG

This project aims to build a suckless Simple Static Web Site Generator.

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

# Terminology

Some words can be though to understand, even with the context.

| Word    | Explanation                                                        |
|:-----   |:------------                                                       |
| draft   | A draft a something write by a writer. It can be published or not. |
| article | An article is something processed by an engine to be reader ready. |
| engine  | An engine is a software that transform a draft into an article.    |
| site    | A site is a group of articles that will accessed by a reader.      |

# Config

Config is separated between multiple files.

**Important notes:** dates must be write as `year month day` and nothing else.
Spaces are not well yet supported. Avoid them as much as you can (for path).

## `site.yml`

| Key              | Default                | Explanation                                   |
| :----            | :--------              | :------------                                 |
| site\_name       | My beautiful website   | Your website name                             |
| site\_domain     | mybeautifulwebsite.org | Your website's domain                         |
| site\_page       | index.html             | You don't have to touch it[1]                 |
| site\_order      | day                    | How your articles are ordered[2]              |
| site\_standalone | false                  | Are your css and cie bundled in html file     |
| site\_engine     | pandoc                 | The engine that will generate your website[3] |
| site\_date\_sep  | -                      | Date field separator                          |
| site\_drafts     | drafts                 | Drafts folder                                 |
| site\_dir        | articles               | Where the site will look for articles         |

### `[1]`

If you want to have anything else as filename generated. With `index.html`
Apache and Nginx don't show a trailing filename in URL bar. Fancier.

### `[2]`

You have available :

* `plain` : everything at root
* `year ` : everything by year
* `month ` : everything by year then month
* `day ` : everything by year then month then day

In any case, articles are put in their own folder.

### `[3]`

Depending on the gerenator, articles's metadata aren't declared at the same
place. You are free to pick the one you want, be just sure to choose a supported
one. If it's not supported, feel free to adjust 2swsg or to open an issue to
request that engine.

Currently supported:

* `pandoc`

# Credit

Bash YAML parser: [here](https://github.com/jasperes/bash-yaml)
