chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'scripts-stock', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()

    require('../index')(@robot)

  it 'registers a respond listener for federal holidays', ->
    expect(@robot.respond).to.have.been.calledWith(/(when is( the)? )?next holiday/i)

  it 'responds to a request for the next federal holiday', ->
    handler = @robot.respond.args[0][1]
    msg = { reply: sinon.spy() }
    handler(msg);
    expect(msg.reply).to.have.been.calledOnce
    expect(msg.reply).to.have.been.calledWithMatch(/the next federal holiday is .*/i)
