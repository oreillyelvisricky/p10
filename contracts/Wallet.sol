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
  mapping (uint => Transfer) transfers;


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

  function updateLayerToMakeATransfer() private {
    //
  }

  function removeLayerToMakeTransfer() private {
    //
  }


  // Add layers to TransferLayers
  // Add Transfer to Transfers
  // If any of them fails... then both of them fail
  function makeTransfer(
    address _receiver,
    uint256 _amount
  ) private {
    //
  }




  event TestLogNumLayersToMakeTransfer(uint _numLayersToMakeTransfer);
  event TestLogTransferLayer(uint256 _amountMin, uint256 _amountMax);


  function test(address _receiver) public virtual {
    testSetLayersToMakeTransfer();
    testLogLayersToMakeTransfer();
  }

  function testSetLayersToMakeTransfer() private {
    addLayerToMakeTransfer(0, 100);

    emit TestLogNumLayersToMakeTransfer(numLayersToMakeTransfer);
  }

  function testLogLayersToMakeTransfer() private {
    //
  }
}
