/*BIOKRIPT SMART CONTRACTS
https://biokript.com/

SPDX-License-Identifier: MIT */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

pragma solidity 0.8.7;

interface IPancakeV2Pair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function _totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(
        address owner,
        address spender
    ) external view returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
        external
        view
        returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(
        address to
    ) external returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}

// pragma solidity 0.8.7;

interface IPancakeV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(
        address tokenA,
        address tokenB
    ) external view returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

pragma solidity 0.8.7;

interface IPancakeV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB, uint256 liquidity);

    function addLiquidityBNB(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountBNBMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (uint256 amountToken, uint256 amountBNB, uint256 liquidity);

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityBNB(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountBNBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountBNB);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityBNBWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountBNBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountBNB);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactBNBForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactBNB(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForBNB(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapBNBForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(
        uint256 amountIn,
        address[] calldata path
    ) external view returns (uint256[] memory amounts);

    function getAmountsIn(
        uint256 amountOut,
        address[] calldata path
    ) external view returns (uint256[] memory amounts);
}

interface IPancakeV2Router02 is IPancakeV2Router01 {
    function removeLiquidityBNBSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountBNBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountBNB);

    function removeLiquidityBNBWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountBNBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountBNB);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactBNBForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForBNBSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

contract BioKript is ERC20, Ownable {

    using SafeMath for uint256;
    IPancakeV2Router02 public pancakeV2Router;
    address public immutable pancakeV2Pair;

    bool private swapping;

    //all profits/revenues will be held here
    address private companyWallet;
    address private burnWallet;
    address private safetyFunds;
    address private reserves;
    address private controller;

    // trading status
    bool public isTradingEnabled;
    // exlcude from fees and max transaction amount
    mapping(address => bool) public _isExcludedFromFees;

    //blacklisting
    uint256 public holdThreshold = 1000000 * 10 ** 18;
    mapping(address => bool) public blacklisted;
    uint256 public constant blacklistThreshold = 3 minutes;
    mapping(address => uint256) public lastTransferStamp;

    //Buy and Sell Tax
    uint256 public buyTax = 3; //3%
    uint256 public sellTax = 3; //3%
    uint256 public liquidityFee = 3; //3%

    //Max Swap Limit
    bool public isSwapLimitEnabled;
    uint256 public MAX_SWAP_LIMIT = 3; //3 Tokens

    //distribution and rewards
    uint256 public distributeTokens;
    mapping (address => bool) public rewardClaimed;

    event ExcludeFromFees(address indexed account, bool isExcluded);

    // event GasForProcessingUpdated(uint256 indexed newValue, uint256 indexed oldValue);

    event SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 bnbReceived,
        uint256 tokensIntoLiqudity
    );

    constructor() ERC20("BKPT", "BKPT") {
    address public distributor = 0x5d135b21EcC60000B0ecDE932617105f04F71EFB;
        controller = 0x83bB8802e28fea889AAF7D8F56ee286af0002409;
        companyWallet = 0x62537084Ad89F5137bad17135cb98D88b971EcbF;
        burnWallet = 0x24C6D745f762be4ad8f165d4a3E0E7c35E443E6E;
        safetyFunds = 0x0DC0ed454b001680B239c55b1bec76F8f93C609D;
        reserves = 0xF41D58658fA316CEEfA20F781424661c1Db5CfBf;
        IPancakeV2Router02 _pancakeV2Router = IPancakeV2Router02(
            0xD99D1c33F9fC3444f8101754aBC46c52416550D1
        ); //(0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3);//(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        // Create a pancake pair for this new token
        pancakeV2Pair = IPancakeV2Factory(_pancakeV2Router.factory())
            .createPair(address(this), _pancakeV2Router.WETH());

        pancakeV2Router = _pancakeV2Router;
        // exclude from paying fees or having max transaction amount
        excludeFromFees(owner(), true);
        excludeFromFees(address(this), true);
        /*
            _mint is an internal function in ERC20.sol that is only called here,
            and CANNOT be called ever again
        */
        _mint(owner(), 500000000 * 10 ** 18);
        emit Transfer(address(0), msg.sender, totalSupply());
    }

    function setBuyTax(uint256 _tax) external onlyOwner {
        buyTax = _tax;
    }

    function setSellTax(uint256 _tax) external onlyOwner {
        sellTax = _tax;
    }

    function setLiquidityFee(uint256 _fee) external onlyOwner {
        liquidityFee = _fee;
    }

    function setMaxHoldLimit(uint256 _amount) external onlyOwner {
        require(_amount > 0);
        holdThreshold = _amount;
    }

    function setSwapLimit(bool _status, uint256 _amount) external onlyOwner {
        require(_amount > 0);
        isSwapLimitEnabled = _status;
        MAX_SWAP_LIMIT = _amount;
    }

    modifier onlyController() {
        require(msg.sender == controller, "Caller: Controller Only!");
        _;
    }

    function burn(uint256 amount) external onlyController {
        uint256 a = (amount * 10 ** 18);
        _burn(msg.sender, a);
    }

    function excludeFromFees(
        address account,
        bool excluded
    ) public onlyController {
        require(
            _isExcludedFromFees[account] != excluded,
            " Account is already the value of 'excluded'"
        );
        _isExcludedFromFees[account] = excluded;

        emit ExcludeFromFees(account, excluded);
    }

    function enableTrade(bool _status) external onlyOwner returns (bool) {
        return isTradingEnabled = _status;
    }

    function addBlacklist(address _bot) external onlyOwner returns (bool) {
        return blacklisted[_bot] = true;
    }

    function removeBlacklist(address _bot) external onlyOwner returns (bool) {
        return blacklisted[_bot] = false;
    }

    function calcTax(
        address _from,
        address _to,
        uint256 _amount
    ) internal returns (uint256) {
        //  require(isTradingEnabled,"Trading is not enabled");
        if (_from == pancakeV2Pair) {
            uint256 lFee = (_amount * liquidityFee) / 100;
            return (((_amount * buyTax) / 100) + lFee);
        } else if (_to == pancakeV2Pair) {
            uint256 lFee = (_amount * liquidityFee) / 100;
            return (((_amount * sellTax) / 100) + lFee);
        }
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0) && to != address(0), "ERC20: zero address");
        require(
            !blacklisted[from] &&
                !blacklisted[to] &&
                lastTransferStamp[msg.sender] + blacklistThreshold <
                block.timestamp,
            "Err: Blacklist"
        );
        require(balanceOf(to) + amount <= holdThreshold, "Err: Max hold");
        uint256 tax = 0;
        // !_isExcludedFromFees[from] || !_isExcludedFromFees[to] &&
        if (from == pancakeV2Pair || to == pancakeV2Pair) {
            tax = calcTax(from, to, amount);
        }
        super._transfer(from, to, amount - tax);
        super._transfer(from, address(this), tax); //owner(), tax);
        lastTransferStamp[msg.sender] = block.timestamp;
    }

    function swapAndLiquify(uint256 tokens) private {
        // split the contract balance into halves
        uint256 half = tokens.div(2);
        uint256 otherHalf = tokens.sub(half);

        // capture the contract's current BNB balance.
        // this is so that we can capture exactly the amount of BNB that the
        // swap creates, and not make the liquidity event include any BNB that
        // has been manually sent to the contract
        uint256 initialBalance = address(this).balance;

        // swap tokens for BNB
        swapTokensForBnb(half); // <- this breaks the Bnb -> HATE swap when swap+liquify is triggered

        // how much Bnb did we just swap into?
        uint256 newBalance = address(this).balance.sub(initialBalance);

        // add liquidity to pancake
        addLiquidity(otherHalf, newBalance);
        emit SwapAndLiquify(half, newBalance, otherHalf);
    }

    function swapTokensForBnb(uint256 tokenAmount) public {
        if (isSwapLimitEnabled) {
            require(tokenAmount < MAX_SWAP_LIMIT, "Max swap reached");
        }
        // generate the pancake pair path of token -> weth
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = pancakeV2Router.WETH();

        _approve(address(this), address(pancakeV2Router), tokenAmount);

        // make the swap
        pancakeV2Router.swapExactTokensForBNBSupportingFeeOnTransferTokens(
            tokenAmount,
            0, // accept any amount of BNB
            path,
            address(this),
            block.timestamp
        );
    }

    function addLiquidity(uint256 tokenAmount, uint256 bnbAmount) private {
        // approve token transfer to cover all possible scenarios
        _approve(address(this), address(pancakeV2Router), tokenAmount);

        // add the liquidity
        pancakeV2Router.addLiquidityBNB{value: bnbAmount}(
            address(this),
            tokenAmount,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            address(0),
            block.timestamp
        );
    }

    function setDistributor(address _address) external {
        require(msg.sender == distributor, "Err: only distributor");
        distributor = _address;
    }

    function distributeInvestors() external {
        require(msg.sender == distributor, "Err: only distributor");
        uint256 revenue = balanceOf(address(this));
        require(revenue > 0, "No revenue to distribute");
        uint256 comTax = (revenue * 40) / 100;
        _transfer(address(this), companyWallet, comTax);
        uint256 burnTax = (revenue * 10) / 100;
        _transfer(address(this), burnWallet, burnTax);
        uint256 safety = (revenue * 5) / 100;
        _transfer(address(this), safetyFunds, safety);
        uint256 reser = (revenue * 5) / 100;
        _transfer(address(this), reserves, reser);
        uint256 amount = (revenue * 40) / 100;
        uint256 tSupply = totalSupply();
        distributeTokens = ((amount * 10 ** 18) / tSupply) % 10 ** 18;  //allocating the number of tokens to be distributed
    }

    function claimRewards() external nonReentrant {
        require(balanceOf(msg.sender)>0 && !rewardClaimed[msg.sender]);
        uint256 distAmount = (distributeTokens * balanceOf(msg.sender)) / (10 ** 18);
        _transfer(address(this), msg.sender, distAmount);
        rewardClaimed[msg.sender] = true;
    }

    function TokenAddress() public view returns (address) {
        return address(this);
    }

    function withdraw() external onlyController {   //empty the contract by transferring all tokens and bnb
        _transfer(address(this), controller, balanceOf(address(this)));
        (bool success, ) = controller.call{value: address(this).balance}("");
        require(success);
    }
}
