#
This readme documentation has steps to execute scrapy in local dev environment and in docker environment. 

# QuotesBot
- This is a Scrapy project to scrape quotes from famous people from http://quotes.toscrape.com 

# Try this proof of concept(POC) in a virtual environment
- Create a virtual env  `python3 -m venv scrapy-env`
- To active venv `source scrapy-env/bin/activate`
- Install scrapy inside the venv `brew install scrapy`
- Clone this repo into venv `git clone https://github.com/karthidec/crawler-handson-poc.git`
- To test:
  - Go to directory `scrapy-env/scrapy-poc/quotesbot`
  - List existing spiders `scrapy list` - It should return result with all spider names
- To run specific spider `scrapy crawl toscrape-css` - It should crawl the web page contents

# Scrapy documentation
- https://docs.scrapy.org/en/latest/intro/overview.html

## Extracted data
This project extracts quotes, combined with the respective author names and tags.
The extracted data looks like this sample:

    {
        'author': 'Douglas Adams',
        'text': '“I may not have gone where I intended to go, but I think I ...”',
        'tags': ['life', 'navigation']
    }

## Spiders
This project contains two spiders and you can list them using the `scrapy list` command:

    $ scrapy list
    toscrape-css
    toscrape-xpath

Both spiders extract the same data from the same website, but `toscrape-css` employs CSS selectors, while `toscrape-xpath` employs XPath expressions.

## Running the spiders

You can run a spider using the `scrapy crawl` command, such as:

    $ scrapy crawl toscrape-css

If you want to save the scraped data to a file, you can pass the `-o` option:
    
    $ scrapy crawl toscrape-css -o quotes.json

# To run separate spider 

    `scrapy runspider quotesbot/spiders/toscrape-css.py -o quotes.jsonl`

# Build in docker environment (using podman)
- Build the container using podman `podman build -t scrapy-app:latest .`
- List podman images `podman images`
    (scrapy-env) ➜  scrapy-poc git:(main) ✗ podman images
    REPOSITORY                                                              TAG                  IMAGE ID      CREATED            SIZE
    localhost/scrapy-app                                                    latest               b4844c43d668  58 seconds ago     1.14 GB

- To tag the built image `podman tag localhost/scrapy-app us-docker.pkg.dev/gpc-d-cloudplatform/containers/scrapy-image`
- To test the build `podman run us-docker.pkg.dev/gpc-d-cloudplatform/containers/scrapy-image:latest`
- To push to artifactory `docker push us-east4-docker.pkg.dev/gpc-d-cloudplatform/scrapy-poc/scrapy-image:latest` (set your cloud project as required prior to this command execution)