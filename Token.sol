pragma solidity ^0.4.16;

 
contract Token{
    function totalSupply() constant returns (uint256 supply) {}
    function balanceOf(address _owner) constant returns (uint256 balance) {}
    function mintable(address _to,uint256 _value) returns(bool success) {}
    function transfer(address _to, uint256 _value) returns (bool success) {}
   
    event Mint(address indexed _owner, uint256 amount);
   
    //event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
}
contract StandardToken is Token{
    
     address _owner;
     mapping (address => uint256) balances;
     mapping(address => mapping(address => uint256)) alowed;
     uint256 public totalSupply;
     
     modifier check()
     {
         require(msg.sender == _owner);
         _;
     }
     
     
     
   
     
     function transfer(address _to,uint256 _value) returns(bool success) {
        require (balances[msg.sender] >= _value && _value > 0 );
             
             balances[msg.sender] -= _value;
             balances[_to] += _value;
             Transfer(msg.sender,_to,_value);
             return true;
          }
     
      function mintable(address _owner, uint256 _amount) check public returns (bool) {
       require (balances[_owner] >= _amount && _amount > 0 );
       
            balances[_owner] += _amount;
              _amount+=totalSupply;
              Mint(_owner, _amount);
            Transfer(address(0), _owner, _amount);
           return true;
      }
     
     function balanceOf(address _owner) constant returns(uint256 balance){
         return balances[_owner];
     }
     
   
     
    
}


contract TestCoin is StandardToken{
    string public name;
    uint8 public decimals;
    string public symbol;
    address public Wallet;
  
    function TestCoin(){
       _owner = msg.sender;
        balances[msg.sender] = 5000;
        totalSupply = 5000;
        Wallet = msg.sender;
        name = "Bank Wallet";
        symbol = "$$";
        decimals = 18;
    }
   
}