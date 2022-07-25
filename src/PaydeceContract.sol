/**
 *Submitted for verification at BscScan.com on 2022-04-01
*/

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/utils/Context.sol";
/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize, which returns 0 for contracts in
        // construction, since the code is only stored at the end of the
        // constructor execution.

        uint256 size;
        assembly {
            size := extcodesize(account)
        }
        return size > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}



/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _setOwner(_msgSender());
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _setOwner(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}


contract CriptoCarsEscrow is Ownable {
    
    event EscrowDeposit(uint indexed orderId,Escrow escrow);
    event EscrowComplete(uint indexed orderId, Escrow escrow);
    event EscrowDisputeResolved(uint indexed orderId);
    event EscrowCancelResolved(uint indexed orderId);
    

    enum EscrowStatus { Unknown, Funded, NOT_USED, Completed, Refund, Arbitration }

    uint256 public feesAvailable;  // summation of fees that can be withdrawn
    
     struct Escrow {
        address payable buyer;  //Comprador
        address payable seller; //Vendedor
        uint256 value;          //Monto compra
        uint256 sellerfee;      //Comision vendedor
        uint256 buyerfee;       //Comision comprador
        EscrowStatus status;    //Estado          
    }
    
    mapping(uint => Escrow) public escrows;
    
    using SafeERC20 for IERC20;
    
    IERC20 immutable private tokenccy;
    
    constructor(IERC20 _currency) {
        tokenccy = _currency;
        feesAvailable = 0;
    }
    
   // Buyer defined as who buys usdt
    modifier onlyBuyer(uint _orderId){
        require(msg.sender == escrows[_orderId].buyer,"Only Buyer can call this");
        _;
    }

    // Seller defined as who sells usdt
    modifier onlySeller(uint _orderId) {
       require(msg.sender == escrows[_orderId].seller,"Only Seller can call this");
        _;
    }
    
   function getState(uint _orderId) public view returns (EscrowStatus){
        Escrow memory _escrow = escrows[_orderId];
        return _escrow.status;
    }

    function getContractBalance() public view returns (uint256){
        return tokenccy.balanceOf(address(this));
    }

    // Get the amount of transaction   
    function getValue(uint _orderId) public view returns (uint256){
        Escrow memory _escrow = escrows[_orderId];
        return _escrow.value;
    }
    
    function getSellerFee(uint _orderId) public view returns (uint256){
        Escrow memory _escrow = escrows[_orderId];
        return _escrow.sellerfee;
    }
    
    function getBuyerFee(uint _orderId) public view returns (uint256){
        Escrow memory _escrow = escrows[_orderId];
        return _escrow.buyerfee;
    }
    
    function getAllowance(uint _orderId) public view returns (uint256){
        Escrow memory _escrow = escrows[_orderId];
        return tokenccy.allowance(_escrow.seller,address(this));
    }
    
    function getFeesAvailable() public view onlyOwner returns (uint256){
        return feesAvailable;
    }

    /* This is called by the server / contract owner */
    function createEscrow(uint _orderId, address payable _buyer, address payable _seller, uint _value, uint _sellerfee, uint _buyerfee) external {
        require(escrows[_orderId].status == EscrowStatus.Unknown, "Escrow already exists");
        
        //Transfer USDT to contract after escrow creation
        require( tokenccy.allowance( _buyer, address(this)) >= (_value),"Seller approve to Escrow first");              

        tokenccy.safeTransferFrom(_buyer, address(this) , (_value) );
        
        escrows[_orderId] = Escrow(_buyer, _seller, _value, _sellerfee, _buyerfee, EscrowStatus.Funded);

        emit EscrowDeposit(_orderId, escrows[_orderId]);
    }

    /* This is called by the buyer wallet */
    function releaseEscrow(uint _orderId) external onlyBuyer(_orderId){            
        require(escrows[_orderId].status == EscrowStatus.Funded,"USDT has not been deposited");             
        
        uint256 _tmpBuyerFee = (escrows[_orderId].buyerfee*escrows[_orderId].value)/(100000000000000000000+escrows[_orderId].buyerfee);
                            // (5*100)/(100+5) = 5/105 = 0.05
        uint256 _tmpSellerFee = (escrows[_orderId].value-_tmpBuyerFee);        
                            // (100-5) = 95
        _tmpSellerFee = (escrows[_orderId].sellerfee*_tmpSellerFee)/100000000000000000000; 
                        //(5*95)/100 = 4.5

        feesAvailable += _tmpBuyerFee + _tmpSellerFee;  // needed for transfer value below
                        // feesAvailable = feesAvailable + 5 + 4.5 = 10.5

        // write as complete, in case transfer fails              
        escrows[_orderId].status = EscrowStatus.Completed;
        
        tokenccy.safeTransfer( escrows[_orderId].seller, escrows[_orderId].value -(_tmpBuyerFee+_tmpSellerFee));        
        
        emit EscrowComplete(_orderId,  escrows[_orderId]);
        delete escrows[_orderId];        
    }
    
    
     /// release funds to the buyer - cancelled contract
    function refundBuyer(uint _orderId) external onlyOwner {       
        //require(escrows[_orderId].status == EscrowStatus.Refund,"Refund not approved");        
                
        // dont charge seller any fees - because its a refund
         
        tokenccy.safeTransfer(escrows[_orderId].buyer, escrows[_orderId].value);
        
        delete escrows[_orderId];
        emit EscrowDisputeResolved(_orderId);
    }
/*
    function approveRefund(uint _orderId) external onlyOwner {        
        require(escrows[_orderId].status == EscrowStatus.Funded,"USDT has not been deposited");
         escrows[_orderId].status = EscrowStatus.Refund;        
    }

    function setArbitration(uint _orderId) external onlyOwner {        
        require(escrows[_orderId].status == EscrowStatus.Funded,"Can not Arbitrate, USDT has not been deposited");
        escrows[_orderId].status = EscrowStatus.Arbitration;        
    }

     /// release funds to the seller/buyer in case of dispute
    function arbitrationEscrow(uint _orderId, uint8 _buyerPercent) external onlyOwner {
        require( (_buyerPercent >= 0 && _buyerPercent <= 100),"Buyer percent out of range");
        Escrow memory _escrow = escrows[_orderId];
        require(_escrow.status == EscrowStatus.Arbitration,"Must be in Arbitrate state");
        
        uint256 _totalFees = _escrow.sellerfee  + _escrow.buyerfee //+ _escrow.additionalGasFees;
        feesAvailable += _totalFees; // deduct fees for arbitration
        
        uint256 amtReturn = (_escrow.value - _totalFees);
        uint256 amtBuyer = (amtReturn * _buyerPercent) / 100;
        uint256 amtSeller = amtReturn - amtBuyer;
        if (amtBuyer > 0){
            tokenccy.safeTransfer(_escrow.buyer, amtBuyer);
        }
        if (amtSeller > 0){
            tokenccy.safeTransfer(_escrow.seller, amtSeller);
        }
        delete escrows[_orderId];
        emit EscrowDisputeResolved(_orderId);
     }

     */

    function withdrawFees(address payable _to, uint256 _amount) external onlyOwner {
        // This check also prevents underflow
        require(_amount <= feesAvailable, "Amount > feesAvailable");
        feesAvailable -= _amount;
        tokenccy.safeTransfer( _to, _amount );
    }

    /*
    Owner y Vendedor puede ejecucar esta funcion para retirar el dinero del contrato
    Devolver la plata al comprador cuando el contrato se cancela
    Devolver todo el dinero al comprador cuando el contrato se cancela
    */
    
    function cancelEscrow(uint _orderId) external onlySeller(_orderId){
        require(escrows[_orderId].status == EscrowStatus.Funded,"Refund not approved"); 

        tokenccy.safeTransfer(escrows[_orderId].buyer, escrows[_orderId].value);
        
        delete escrows[_orderId];
        emit EscrowCancelResolved(_orderId);
    }
}