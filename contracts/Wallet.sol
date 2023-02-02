// SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract Wallet {
  // Layer Lib


  struct AmountMinMax {
    uint256 min;
    uint256 max;
  }

  struct Layer {
    AmountMinMax amount;

    uint numTokens;
    mapping (uint => string) tokens;
    
    // Layers Lib
  }


  uint numLayersToMakeTransfer;
  mapping (uint => Layer) LayersToMakeTransfer;

  uint numTransferLayers;
  mapping (uint => mapping (uint => Layer)) TransferLayers;

  struct Transfer {
    uint256 transferNum;

    address receiver;
    uint256 amount;

    uint256 transferLayersIndex;

    bool executed;
  }

  uint numTransfers;
  mapping (uint => Transfer) Transfers;


  function addLayerToMakeTransfer(
    uint256 _amountMin,
    uint256 _amountMax
  ) private {
    Layer storage layer = LayersToMakeTransfer[numLayersToMakeTransfer];

    AmountMinMax memory amount = AmountMinMax({
      min: _amountMin,
      max: _amountMax
    });

    layer.amount = amount;

    // TODO pass in function
    string [2] memory _tokens = [ "ETH", "USDC" ];

    for (uint i = 0; i < _tokens.length; i++) {
      string memory token = _tokens[i];

      layer.tokens[i] = token;

      layer.numTokens++;
    }

    numLayersToMakeTransfer++;
  }

  function updateLayerToMakeTransfer() private {
    //
  }

  function removeLayerToMakeTransfer() private {
    //
  }


  function makeTransfer(
    address _receiver,
    uint256 _amount
  ) private {
    // How to check if any fails. Then make them both fail.
    addTransferLayers();
    addTransfer(_receiver, _amount);
  }

  function addTransferLayers() private {
    for (uint layerNum = 0; layerNum < numLayersToMakeTransfer; layerNum++) {
      Layer storage _layer = LayersToMakeTransfer[layerNum];

      Layer storage layer = TransferLayers[numTransfers][layerNum];

      AmountMinMax amount = AmountMinMax({
        min: _layer.amount.min,
        max: _layer.amount.max
      });

      layer.amount = amount;

      layer.numTokens = _layer.numTokens;

      for (uint tokenNum = 0; tokenNum < _layer.numTokens; tokenNum++) {
        string token = _layer.tokens[tokenNum];

        layer.tokens[tokenNum] = token;
      }
    }
  }

  function addTransfer(
    address _receiver,
    uint256 _amount
  ) private {
    Transfer storage transfer = Transfers[numTransfers];

    transfer.transferNum = numTransfers;

    transfer.receiver = _receiver;
    transfer.amount = _amount;

    transfer.transferLayersIndex = numTransfers;

    transfer.executed = false;
  }




  event TestLogNumLayersToMakeTransfer(uint _numLayersToMakeTransfer);
  event TestLogTransferLayer(uint256 _amountMin, uint256 _amountMax);


  function test(address _receiver) public virtual {
    testSetLayersToMakeTransfer();
    testLogLayersToMakeTransfer();
  }

  function testSetLayersToMakeTransfer() private {
    addLayerToMakeTransfer(0, 100);
    addLayerToMakeTransfer(100, 120);
    addLayerToMakeTransfer(120, 140);
    addLayerToMakeTransfer(140, 1000);

    emit TestLogNumLayersToMakeTransfer(numLayersToMakeTransfer);
  }

  function testMakeTransfer() private {
    //
  }

  function testLogLayersToMakeTransfer() private {
    //
  }
}
