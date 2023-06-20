/*BIOKRIPT SMART CONTRACTS
https://biokript.com/

SPDX-License-Identifier: MIT */

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

pragma solidity 0.8.18;

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

    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

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
        returns (
            uint112 reserve0,
            uint112 reserve1,
            uint32 blockTimestampLast
        );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to)
        external
        returns (uint256 amount0, uint256 amount1);

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

interface IPancakeV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

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
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

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
        returns (
            uint256 amountToken,
            uint256 amountBNB,
            uint256 liquidity
        );

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

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
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

contract BioKript is ERC20, Ownable, ReentrancyGuard {
    using SafeMath for uint256;
    address public immutable pancakeV2Pair;

    //all profits/revenues will be held here
    address private distributor;
    address private companyWallet;
    address private burnWallet;
    address private safetyFunds;
    address private reserves;
    address private controller;
    address private liquidityReceiver;
    address private feeReceiver;

    // exlcude from fees and max transaction amount
    mapping(address => bool) public _isExcludedFromFees;

    uint256 public holdThreshold = 1000000 * 10**18;

    //Buy and Sell Tax
    uint256 public buyTax; // 3% Buy Tax
    uint256 public sellTax; // 3% Sell Tax
    uint256 public liquidityFee; // 2% liquidity fee

    //distribution and rewards
    mapping(address => uint256) private claimDur;
    uint256 public nextDistr; //next distribution
    uint256 public distributeTokens;
    // Initiate this this current balance when user comes to platform first.
    mapping(address => uint256) private previousBalance;
    mapping(address => bool) private _isLiquidityPair;

    event ExcludeFromFees(address indexed account, bool isExcluded);

    event UpdatePair(address indexed _address, bool status);

    constructor() ERC20("Biokript", "BKPT") {
        distributor = 0x6a07bB46D93c4BF298E1aCf67bDBd163e7B793c6;//0xa07be378B303cEbb44B6692819ED1910BDc906C6;
        controller = 0x6a07bB46D93c4BF298E1aCf67bDBd163e7B793c6;//0xa07be378B303cEbb44B6692819ED1910BDc906C6;
        companyWallet = 0x62537084Ad89F5137bad17135cb98D88b971EcbF;
        burnWallet = 0x24C6D745f762be4ad8f165d4a3E0E7c35E443E6E;
        safetyFunds = 0x0DC0ed454b001680B239c55b1bec76F8f93C609D;
        reserves = 0xF41D58658fA316CEEfA20F781424661c1Db5CfBf;
        liquidityReceiver = 0xe1a2967DeAb90287cbE1c57768a0d347ccd8f530;
        feeReceiver = 0x4ed2D84a05DB7212039B4290507762Da79D4Ceb7;

        IPancakeV2Router02 _pancakeV2Router = IPancakeV2Router02(
            0xD99D1c33F9fC3444f8101754aBC46c52416550D1  
        ); //(0x9Ac64Cc6e4415144C455BD8E4837Fea55603e5c3);//(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        // Create a pancake pair for this new token
        pancakeV2Pair = IPancakeV2Factory(_pancakeV2Router.factory())
            .createPair(address(this), _pancakeV2Router.WETH());

        _isLiquidityPair[pancakeV2Pair] = true;

        // exclude from paying fees or having max transaction amount
        excludeFromFees(owner(), true);
        excludeFromFees(address(this), true);
        nextDistr = block.timestamp;
        /*
            _mint is an internal function in ERC20.sol that is only called here,
            and CANNOT be called ever again
        */

        // Initially set high tax (Anti-bot)
        buyTax = 50;
        sellTax = 50;

        _mint(owner(), 500000000 * 10**18);
        emit Transfer(address(0), msg.sender, totalSupply());
    }

    function setBuyTax(uint256 _tax) external onlyController {
        buyTax = _tax;
    }

    function setSellTax(uint256 _tax) external onlyController {
        sellTax = _tax;
    }

    function setLiquidityFee(uint256 _fee) external onlyController {
        liquidityFee = _fee;
    }

    function setMaxHoldLimit(uint256 _amount) external onlyController {
        require(_amount > 0);
        holdThreshold = _amount;
    }

    modifier onlyController() {
        require(msg.sender == controller, "Caller: Controller Only!");
        _;
    }

    function burn(uint256 amount) external onlyController {
        _burn(msg.sender, amount);
    }

    function excludeFromFees(address account, bool excluded)
        public
        onlyController
    {
        require(
            _isExcludedFromFees[account] != excluded,
            " Account is already the value of 'excluded'"
        );
        _isExcludedFromFees[account] = excluded;

        emit ExcludeFromFees(account, excluded);
    }

    function calcTax(
        address _from,
        address _to,
        uint256 _amount
    ) internal view returns (uint256, uint256) {
        uint256 liqFee = 0;
        if (_isLiquidityPair[_from]) {
            // Buy tax 3% total
            return ((_amount * buyTax) / 100, liqFee);
        } else if (_isLiquidityPair[_to]) {
            // Sell tax 5% total
            liqFee = (_amount * liquidityFee) / 100;
            return (((_amount * sellTax) / 100), liqFee);
        } else {
            return (0, liqFee);
        }
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal override {
        require(from != address(0) && to != address(0), "ERC20: zero address");
        require(
            balanceOf(to) + amount <= holdThreshold ||
                _isExcludedFromFees[from],
            "Err: Max hold"
        );
        uint256 tax = 0;
        uint256 liqFee = 0;
        if (
            !_isExcludedFromFees[from] ||
            _isLiquidityPair[from] ||
            _isLiquidityPair[to]
        ) {
            (tax, liqFee) = calcTax(from, to, amount);
        }

        super._transfer(from, to, amount - (tax + liqFee));
        if (tax > 0) super._transfer(from, feeReceiver, tax);
        if (liqFee > 0) super._transfer(from, liquidityReceiver, liqFee);

        // Initiate with current balance (updated when claimed)
        if ((previousBalance[from] == 0 && balanceOf(msg.sender) != 0)) {
            previousBalance[from] = balanceOf(from);
        }
        if (previousBalance[to] == 0 && balanceOf(to) != 0) {
            previousBalance[to] = balanceOf(to);
        }
    }

    function setDistributor(address _address) external {
        require(msg.sender == distributor, "Err: only distributor");
        distributor = _address;
    }

    function distributeInvestors() external {
        require(msg.sender == distributor, "Err: only distributor");
        require(
            block.timestamp >= nextDistr,
            "Distribution duration not passed!"
        );
        uint256 revenue = balanceOf(address(this));
        require(revenue > 0, "No revenue to distribute");
        uint256 companyTax = (revenue * 40) / 100;
        _transfer(address(this), companyWallet, companyTax);
        uint256 burnTax = (revenue * 10) / 100;
        _transfer(address(this), burnWallet, burnTax);
        uint256 safetyTax = (revenue * 5) / 100;
        _transfer(address(this), safetyFunds, safetyTax);
        uint256 reserveTax = (revenue * 5) / 100;
        _transfer(address(this), reserves, reserveTax);
        uint256 amount = (revenue * 40) / 100;
        uint256 tSupply = totalSupply() / 10**18;
        distributeTokens = (amount) / tSupply; //allocating the number of tokens to be distributed
        nextDistr = block.timestamp + 30 days;
    }

    function claimRewards() external nonReentrant {
        uint256 distAmount = claimableRewardAmount(msg.sender);

        require(
            block.timestamp >= claimDur[msg.sender],
            "Wait for the next distribution"
        );
        require(distAmount > 0, "No claimable rewards left");

        _transfer(address(this), msg.sender, distAmount);
        previousBalance[msg.sender] = balanceOf(msg.sender);
        claimDur[msg.sender] = nextDistr;
    }

    function claimableRewardAmount(address wallet)
        public
        view
        returns (uint256)
    {
        uint256 distAmount = 0;
        if (block.timestamp >= claimDur[wallet]) {
            uint256 potential = previousBalance[wallet] / 10**18;
            distAmount = (distributeTokens * (potential - 1));
        }
        return distAmount;
    }

    function withdraw() external onlyController {
        //empty the contract by transferring all tokens and bnb
        _transfer(address(this), controller, balanceOf(address(this)));
        (bool success, ) = controller.call{value: address(this).balance}("");
        require(success);
    }

    // Add liquidity pair
    function addLiquidityPair(address _address, bool status)
        external
        onlyController
    {
        _isLiquidityPair[_address] = status;
        emit UpdatePair(_address, status);
    }

    // Check if liquidity pair
    function IsLiquidityPair(address _address) external view returns (bool) {
        return _isLiquidityPair[_address];
    }
}