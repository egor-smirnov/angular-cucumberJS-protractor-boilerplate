chai = require 'chai'
chaiAsPromised = require 'chai-as-promised'
chai.use chaiAsPromised
expect = chai.expect
By = `by`

backEndMocks = require '../httpBackendMocks'

module.exports = ->

    @Given /^I am in the auction room$/, (next) ->

        browser.clearMockModules()

        browser.addMockModule 'httpBackendMocks', backEndMocks.prepareMultipleScenarioMock(backEndMocks.auctionRoomScenarioMocks)
        browser.get '#/auction-room'

        next()

    @Then /^I see the current item picture, description and name$/, (next) ->

        picture = element(By.css('.auctionItem__picture'))
        expect(picture.getAttribute('src'))
            .to.eventually.equal('http://media-cache-ec0.pinimg.com/736x/78/f8/18/78f8183fcbfba15ba05889b1c6fd652b.jpg')

        description = element(By.css('.auctionItem__description'))
        expect(description.getText())
            .to.eventually.equal('This magnificent selection of Cartier jewelry...')

        name = element(By.css('.auctionItem__name'))
        expect(name.getText())
            .to.eventually.equal('Cartier Paris, Collection Privée, Pasha de Cartier')
            .and.notify(next)

    @Then /^I see the current highest bid with a button to place a new bid$/, (next) ->

        currentHighestBid = element(By.css('.auctionBid__currentHighestBid'))
        expect(currentHighestBid.getText())
            .to.eventually.match(/20000/)

        placeNewBidButton = element(By.css('.auctionBid__placeNewBidBtn'))
        expect(placeNewBidButton.isPresent())
            .to.eventually.be.true
            .and.notify(next)

    @When /^I place a bid on an item$/, (next) ->

        placeNewBidButton = element(By.css('.auctionBid__placeNewBidBtn'))
        placeNewBidButton.click().then(() ->
                next()
        )

    @When /^I am the only bidder$/, (next) ->

        allBidders = element(By.css('.auctionBid__allBidders'))
        expect(allBidders.getText())
            .to.eventually.equal('Egor Smirnov')

        allBiddersItems = element.all(By.css('.auctionBid__allBidders li'))
        expect(allBiddersItems.count())
            .to.eventually.equal(1)
            .and.notify(next)

    @Then /^I am the highest bidder$/,  (next) ->

        highestBidder = element(By.css('.auctionBid__highestBidder'))
        expect(highestBidder.getText())
            .to.eventually.match(/Egor Smirnov/)
            .and.notify(next)

    @When /^I am not the only bidder$/, (next) ->

        allBidders = element(By.css('.auctionBid__allBidders'))
        expect(allBidders.getText())
            .to.eventually.not.equal('Egor Smirnov')

        allBiddersItems = element.all(By.css('.auctionBid__allBidders li'))
        expect(allBiddersItems.count())
            .to.eventually.be.above(1)
            .and.notify(next)

    @When /^my bid was placed first$/, (next) ->

        allBiddersItems = element.all(By.css('.auctionBid__allBids li'))
        expect(allBiddersItems.get(0).getText())
            .to.eventually.be.equal('Bid by Egor Smirnov')
            .and.notify(next)

    @When /^my bid was not placed first$/, (next) ->

        allBiddersItems = element.all(By.css('.auctionBid__allBids li'))
        expect(allBiddersItems.get(0).getText())
            .to.eventually.be.not.equal('Bid by Egor Smirnov')

        expect(allBiddersItems.get(0).getText())
            .to.eventually.be.equal('Bid by Ivan Ivanov')
            .and.notify(next)

    @Then /^I am not the highest bidder$/, (next) ->

        highestBidder = element(By.css('.auctionBid__highestBidder'))
        expect(highestBidder.getText())
            .to.eventually.not.match(/Egor Smirnov/)
            .and.notify(next)