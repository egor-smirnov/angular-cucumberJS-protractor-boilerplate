passThrough = ($httpBackend) ->
    $httpBackend.whenGET(/\/partials\//).passThrough()

currentMockScenario = 0

module.exports.prepareMock = (mockFunc) ->

    scriptStr = '''
        angular.module('httpBackendMocks', ['ngMockE2E'])
            .run(
            '''
    scriptStr += mockFunc
    scriptStr += ')'
    scriptStr += '.run(' + passThrough + ')'

    fn = Function(scriptStr)
    fn

module.exports.prepareMultipleScenarioMock = (mockFunc) ->

    scriptStr = '''
        angular.module('httpBackendMocks', ['ngMockE2E'])
            .run(
            '''
    scriptStr += if mockFunc[currentMockScenario] then mockFunc[currentMockScenario] else mockFunc[0]
    scriptStr += ')'
    scriptStr += '.run(' + passThrough + ')'

    currentMockScenario++

    fn = Function(scriptStr)
    fn

typicalScenario = ($httpBackend) ->

    currentAuctionItem = {
        id: 50
        name: 'Cartier Paris, Collection Privée, Pasha de Cartier'
        picture: 'http://media-cache-ec0.pinimg.com/736x/78/f8/18/78f8183fcbfba15ba05889b1c6fd652b.jpg'
        description: 'This magnificent selection of Cartier jewelry...'
        currentBid: 20000
        nextBid: 40000
    }

    $httpBackend.whenPOST('items/50/bids', {userId: 1}).respond
        success: true

    $httpBackend.whenGET('items').respond currentAuctionItem

iAmTheOnlyBidderScenario = ($httpBackend) ->

    currentAuctionItem = {
        id: 50
        name: 'Cartier Paris, Collection Privée, Pasha de Cartier'
        picture: 'http://media-cache-ec0.pinimg.com/736x/78/f8/18/78f8183fcbfba15ba05889b1c6fd652b.jpg'
        description: 'This magnificent selection of Cartier jewelry...'
        currentBid: 20000
        nextBid: 40000
    }

    $httpBackend.whenPOST('items/50/bids', {userId: 1}).respond
        success: true

    $httpBackend.whenGET('items').respond currentAuctionItem
    $httpBackend.whenGET('items/50/bidders').respond [{userId: 1, name: 'Egor Smirnov'}]

multipleBiddersIAmFirstScenario = ($httpBackend) ->

    currentAuctionItem = {
        id: 50
        name: 'Cartier Paris, Collection Privée, Pasha de Cartier'
        picture: 'http://media-cache-ec0.pinimg.com/736x/78/f8/18/78f8183fcbfba15ba05889b1c6fd652b.jpg'
        description: 'This magnificent selection of Cartier jewelry...'
        currentBid: 20000
        nextBid: 40000
    }

    $httpBackend.whenPOST('items/50/bids', {userId: 1}).respond
        success: true

    $httpBackend.whenGET('items').respond currentAuctionItem
    $httpBackend.whenGET('items/50/bidders').respond [
        {userId: 1, name: 'Egor Smirnov'}
        {userId: 2, name: 'Ivan Ivanov'}
        {userId: 3, name: 'John Doe'}
    ]

    $httpBackend.whenGET('items/50/bids').respond [
        {time: 1415485860, bidValue: 40000, userId: 1, name: 'Egor Smirnov'}
        {time: 1415485870, bidValue: 40000, userId: 2, name: 'Ivan Ivanov'}
        {time: 1415485880, bidValue: 40000, userId: 3, name: 'John Doe'}
    ]

multipleBiddersIAmNotFirstScenario = ($httpBackend) ->

    currentAuctionItem = {
        id: 50
        name: 'Cartier Paris, Collection Privée, Pasha de Cartier'
        picture: 'http://media-cache-ec0.pinimg.com/736x/78/f8/18/78f8183fcbfba15ba05889b1c6fd652b.jpg'
        description: 'This magnificent selection of Cartier jewelry...'
        currentBid: 20000
        nextBid: 40000
    }

    $httpBackend.whenPOST('items/50/bids', {userId: 1}).respond
        success: true

    $httpBackend.whenGET('items').respond currentAuctionItem
    $httpBackend.whenGET('items/50/bidders').respond [
        {userId: 1, name: 'Egor Smirnov'}
        {userId: 2, name: 'Ivan Ivanov'}
        {userId: 3, name: 'John Doe'}
    ]

    $httpBackend.whenGET('items/50/bids').respond [
        {time: 1415485860, bidValue: 40000, userId: 2, name: 'Ivan Ivanov'}
        {time: 1415485870, bidValue: 40000, userId: 1, name: 'Egor Smirnov'}
        {time: 1415485880, bidValue: 40000, userId: 3, name: 'John Doe'}
    ]

auctionRoomScenarioMocks = [
    typicalScenario
    iAmTheOnlyBidderScenario
    multipleBiddersIAmFirstScenario
    multipleBiddersIAmNotFirstScenario
]

module.exports.auctionRoomScenarioMocks = auctionRoomScenarioMocks
