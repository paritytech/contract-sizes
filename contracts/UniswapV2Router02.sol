pragma solidity =0.6.6;

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint32);

    function feeTo() external view returns (address);
    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB) external view returns (address pair);
    function allPairs(uint32) external view returns (address pair);
    function allPairsLength() external view returns (uint32);

    function createPair(address tokenA, address tokenB) external returns (address pair);

    function setFeeTo(address) external;
    function setFeeToSetter(address) external;
}

interface IUniswapV2Pair {
    event Approval(address indexed owner, address indexed spender, uint32 value);
    event Transfer(address indexed from, address indexed to, uint32 value);

    function name() external pure returns (string memory);
    function symbol() external pure returns (string memory);
    function decimals() external pure returns (uint8);
    function totalSupply() external view returns (uint32);
    function balanceOf(address owner) external view returns (uint32);
    function allowance(address owner, address spender) external view returns (uint32);

    function approve(address spender, uint32 value) external returns (bool);
    function transfer(address to, uint32 value) external returns (bool);
    function transferFrom(address from, address to, uint32 value) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);
    function PERMIT_TYPEHASH() external pure returns (bytes32);
    function nonces(address owner) external view returns (uint32);

    function permit(address owner, address spender, uint32 value, uint32 deadline, uint8 v, bytes32 r, bytes32 s) external;

    event Mint(address indexed sender, uint32 amount0, uint32 amount1);
    event Burn(address indexed sender, uint32 amount0, uint32 amount1, address indexed to);
    event Swap(
        address indexed sender,
        uint32 amount0In,
        uint32 amount1In,
        uint32 amount0Out,
        uint32 amount1Out,
        address indexed to
    );
    event Sync(uint32 reserve0, uint32 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint32);
    function factory() external view returns (address);
    function token0() external view returns (address);
    function token1() external view returns (address);
    function getReserves() external view returns (uint32 reserve0, uint32 reserve1, uint32 blockTimestampLast);
    function price0CumulativeLast() external view returns (uint32);
    function price1CumulativeLast() external view returns (uint32);
    function kLast() external view returns (uint32);

    function mint(address to) external returns (uint32 liquidity);
    function burn(address to) external returns (uint32 amount0, uint32 amount1);
    function swap(uint32 amount0Out, uint32 amount1Out, address to, bytes calldata data) external;
    function skim(address to) external;
    function sync() external;

    function initialize(address, address) external;
}

interface IUniswapV2Router01 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint32 amountADesired,
        uint32 amountBDesired,
        uint32 amountAMin,
        uint32 amountBMin,
        address to,
        uint32 deadline
    ) external returns (uint32 amountA, uint32 amountB, uint32 liquidity);
    function addLiquidityETH(
        address token,
        uint32 amountTokenDesired,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline
    ) external payable returns (uint32 amountToken, uint32 amountETH, uint32 liquidity);
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint32 liquidity,
        uint32 amountAMin,
        uint32 amountBMin,
        address to,
        uint32 deadline
    ) external returns (uint32 amountA, uint32 amountB);
    function removeLiquidityETH(
        address token,
        uint32 liquidity,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline
    ) external returns (uint32 amountToken, uint32 amountETH);
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint32 liquidity,
        uint32 amountAMin,
        uint32 amountBMin,
        address to,
        uint32 deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint32 amountA, uint32 amountB);
    function removeLiquidityETHWithPermit(
        address token,
        uint32 liquidity,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint32 amountToken, uint32 amountETH);
    function swapExactTokensForTokens(
        uint32 amountIn,
        uint32 amountOutMin,
        address[] calldata path,
        address to,
        uint32 deadline
    ) external returns (uint32[] memory amounts);
    function swapTokensForExactTokens(
        uint32 amountOut,
        uint32 amountInMax,
        address[] calldata path,
        address to,
        uint32 deadline
    ) external returns (uint32[] memory amounts);
    function swapExactETHForTokens(uint32 amountOutMin, address[] calldata path, address to, uint32 deadline)
        external
        payable
        returns (uint32[] memory amounts);
    function swapTokensForExactETH(uint32 amountOut, uint32 amountInMax, address[] calldata path, address to, uint32 deadline)
        external
        returns (uint32[] memory amounts);
    function swapExactTokensForETH(uint32 amountIn, uint32 amountOutMin, address[] calldata path, address to, uint32 deadline)
        external
        returns (uint32[] memory amounts);
    function swapETHForExactTokens(uint32 amountOut, address[] calldata path, address to, uint32 deadline)
        external
        payable
        returns (uint32[] memory amounts);

    function quote(uint32 amountA, uint32 reserveA, uint32 reserveB) external pure returns (uint32 amountB);
    function getAmountOut(uint32 amountIn, uint32 reserveIn, uint32 reserveOut) external pure returns (uint32 amountOut);
    function getAmountIn(uint32 amountOut, uint32 reserveIn, uint32 reserveOut) external pure returns (uint32 amountIn);
    function getAmountsOut(uint32 amountIn, address[] calldata path) external view returns (uint32[] memory amounts);
    function getAmountsIn(uint32 amountOut, address[] calldata path) external view returns (uint32[] memory amounts);
}

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint32 liquidity,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline
    ) external returns (uint32 amountETH);
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint32 liquidity,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external returns (uint32 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint32 amountIn,
        uint32 amountOutMin,
        address[] calldata path,
        address to,
        uint32 deadline
    ) external;
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint32 amountOutMin,
        address[] calldata path,
        address to,
        uint32 deadline
    ) external payable;
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint32 amountIn,
        uint32 amountOutMin,
        address[] calldata path,
        address to,
        uint32 deadline
    ) external;
}

interface IERC20 {
    event Approval(address indexed owner, address indexed spender, uint32 value);
    event Transfer(address indexed from, address indexed to, uint32 value);

    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
    function totalSupply() external view returns (uint32);
    function balanceOf(address owner) external view returns (uint32);
    function allowance(address owner, address spender) external view returns (uint32);

    function approve(address spender, uint32 value) external returns (bool);
    function transfer(address to, uint32 value) external returns (bool);
    function transferFrom(address from, address to, uint32 value) external returns (bool);
}

interface IWETH {
    function deposit() external payable;
    function transfer(address to, uint32 value) external returns (bool);
    function withdraw(uint32) external;
}

contract UniswapV2Router02 is IUniswapV2Router02 {
    using SafeMath for uint32;

    address public immutable override factory;
    address public immutable override WETH;

    modifier ensure(uint32 deadline) {
        require(deadline >= block.timestamp, 'UniswapV2Router: EXPIRED');
        _;
    }

    constructor(address _factory, address _WETH) public {
        factory = _factory;
        WETH = _WETH;
    }

    receive() external payable {
        assert(msg.sender == WETH); // only accept ETH via fallback from the WETH contract
    }

    // **** ADD LIQUIDITY ****
    function _addLiquidity(
        address tokenA,
        address tokenB,
        uint32 amountADesired,
        uint32 amountBDesired,
        uint32 amountAMin,
        uint32 amountBMin
    ) internal virtual returns (uint32 amountA, uint32 amountB) {
        // create the pair if it doesn't exist yet
        if (IUniswapV2Factory(factory).getPair(tokenA, tokenB) == address(0)) {
            IUniswapV2Factory(factory).createPair(tokenA, tokenB);
        }
        (uint32 reserveA, uint32 reserveB) = UniswapV2Library.getReserves(factory, tokenA, tokenB);
        if (reserveA == 0 && reserveB == 0) {
            (amountA, amountB) = (amountADesired, amountBDesired);
        } else {
            uint32 amountBOptimal = UniswapV2Library.quote(amountADesired, reserveA, reserveB);
            if (amountBOptimal <= amountBDesired) {
                require(amountBOptimal >= amountBMin, 'UniswapV2Router: INSUFFICIENT_B_AMOUNT');
                (amountA, amountB) = (amountADesired, amountBOptimal);
            } else {
                uint32 amountAOptimal = UniswapV2Library.quote(amountBDesired, reserveB, reserveA);
                assert(amountAOptimal <= amountADesired);
                require(amountAOptimal >= amountAMin, 'UniswapV2Router: INSUFFICIENT_A_AMOUNT');
                (amountA, amountB) = (amountAOptimal, amountBDesired);
            }
        }
    }
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint32 amountADesired,
        uint32 amountBDesired,
        uint32 amountAMin,
        uint32 amountBMin,
        address to,
        uint32 deadline
    ) external virtual override ensure(deadline) returns (uint32 amountA, uint32 amountB, uint32 liquidity) {
        (amountA, amountB) = _addLiquidity(tokenA, tokenB, amountADesired, amountBDesired, amountAMin, amountBMin);
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);
        TransferHelper.safeTransferFrom(tokenA, msg.sender, pair, amountA);
        TransferHelper.safeTransferFrom(tokenB, msg.sender, pair, amountB);
        liquidity = IUniswapV2Pair(pair).mint(to);
    }
    function addLiquidityETH(
        address token,
        uint32 amountTokenDesired,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline
    ) external virtual override payable ensure(deadline) returns (uint32 amountToken, uint32 amountETH, uint32 liquidity) {
        (amountToken, amountETH) = _addLiquidity(
            token,
            WETH,
            amountTokenDesired,
            uint32(msg.value),
            amountTokenMin,
            amountETHMin
        );
        address pair = UniswapV2Library.pairFor(factory, token, WETH);
        TransferHelper.safeTransferFrom(token, msg.sender, pair, amountToken);
        IWETH(WETH).deposit{value: amountETH}();
        assert(IWETH(WETH).transfer(pair, amountETH));
        liquidity = IUniswapV2Pair(pair).mint(to);
        // refund dust eth, if any
        if (uint32(msg.value) > amountETH) TransferHelper.safeTransferETH(msg.sender, uint32(msg.value) - amountETH);
    }

    // **** REMOVE LIQUIDITY ****
    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint32 liquidity,
        uint32 amountAMin,
        uint32 amountBMin,
        address to,
        uint32 deadline
    ) public virtual override ensure(deadline) returns (uint32 amountA, uint32 amountB) {
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);
        IUniswapV2Pair(pair).transferFrom(msg.sender, pair, liquidity); // send liquidity to pair
        (uint32 amount0, uint32 amount1) = IUniswapV2Pair(pair).burn(to);
        (address token0,) = UniswapV2Library.sortTokens(tokenA, tokenB);
        (amountA, amountB) = tokenA == token0 ? (amount0, amount1) : (amount1, amount0);
        require(amountA >= amountAMin, 'UniswapV2Router: INSUFFICIENT_A_AMOUNT');
        require(amountB >= amountBMin, 'UniswapV2Router: INSUFFICIENT_B_AMOUNT');
    }
    function removeLiquidityETH(
        address token,
        uint32 liquidity,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline
    ) public virtual override ensure(deadline) returns (uint32 amountToken, uint32 amountETH) {
        (amountToken, amountETH) = removeLiquidity(
            token,
            WETH,
            liquidity,
            amountTokenMin,
            amountETHMin,
            address(this),
            deadline
        );
        TransferHelper.safeTransfer(token, to, amountToken);
        IWETH(WETH).withdraw(amountETH);
        TransferHelper.safeTransferETH(to, amountETH);
    }
    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint32 liquidity,
        uint32 amountAMin,
        uint32 amountBMin,
        address to,
        uint32 deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint32 amountA, uint32 amountB) {
        address pair = UniswapV2Library.pairFor(factory, tokenA, tokenB);
        uint32 value = approveMax ? uint32(-1) : liquidity;
        IUniswapV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        (amountA, amountB) = removeLiquidity(tokenA, tokenB, liquidity, amountAMin, amountBMin, to, deadline);
    }
    function removeLiquidityETHWithPermit(
        address token,
        uint32 liquidity,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint32 amountToken, uint32 amountETH) {
        address pair = UniswapV2Library.pairFor(factory, token, WETH);
        uint32 value = approveMax ? uint32(-1) : liquidity;
        IUniswapV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        (amountToken, amountETH) = removeLiquidityETH(token, liquidity, amountTokenMin, amountETHMin, to, deadline);
    }

    // **** REMOVE LIQUIDITY (supporting fee-on-transfer tokens) ****
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint32 liquidity,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline
    ) public virtual override ensure(deadline) returns (uint32 amountETH) {
        (, amountETH) = removeLiquidity(
            token,
            WETH,
            liquidity,
            amountTokenMin,
            amountETHMin,
            address(this),
            deadline
        );
        TransferHelper.safeTransfer(token, to, IERC20(token).balanceOf(address(this)));
        IWETH(WETH).withdraw(amountETH);
        TransferHelper.safeTransferETH(to, amountETH);
    }
    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint32 liquidity,
        uint32 amountTokenMin,
        uint32 amountETHMin,
        address to,
        uint32 deadline,
        bool approveMax, uint8 v, bytes32 r, bytes32 s
    ) external virtual override returns (uint32 amountETH) {
        address pair = UniswapV2Library.pairFor(factory, token, WETH);
        uint32 value = approveMax ? uint32(-1) : liquidity;
        IUniswapV2Pair(pair).permit(msg.sender, address(this), value, deadline, v, r, s);
        amountETH = removeLiquidityETHSupportingFeeOnTransferTokens(
            token, liquidity, amountTokenMin, amountETHMin, to, deadline
        );
    }

    // **** SWAP ****
    // requires the initial amount to have already been sent to the first pair
    function _swap(uint32[] memory amounts, address[] memory path, address _to) internal virtual {
        for (uint32 i = 0; i < uint32(path.length) - 1; i++) {
            (address input, address output) = (path[i], path[i + 1]);
            (address token0,) = UniswapV2Library.sortTokens(input, output);
            uint32 amountOut = amounts[i + 1];
            (uint32 amount0Out, uint32 amount1Out) = input == token0 ? (uint32(0), amountOut) : (amountOut, uint32(0));
            address to = i < path.length - 2 ? UniswapV2Library.pairFor(factory, output, path[i + 2]) : _to;
            IUniswapV2Pair(UniswapV2Library.pairFor(factory, input, output)).swap(
                amount0Out, amount1Out, to, new bytes(0)
            );
        }
    }
    function swapExactTokensForTokens(
        uint32 amountIn,
        uint32 amountOutMin,
        address[] calldata path,
        address to,
        uint32 deadline
    ) external virtual override ensure(deadline) returns (uint32[] memory amounts) {
        amounts = UniswapV2Library.getAmountsOut(factory, amountIn, path);
        require(amounts[amounts.length - 1] >= amountOutMin, 'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        _swap(amounts, path, to);
    }
    function swapTokensForExactTokens(
        uint32 amountOut,
        uint32 amountInMax,
        address[] calldata path,
        address to,
        uint32 deadline
    ) external virtual override ensure(deadline) returns (uint32[] memory amounts) {
        amounts = UniswapV2Library.getAmountsIn(factory, amountOut, path);
        require(amounts[0] <= amountInMax, 'UniswapV2Router: EXCESSIVE_INPUT_AMOUNT');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        _swap(amounts, path, to);
    }
    function swapExactETHForTokens(uint32 amountOutMin, address[] calldata path, address to, uint32 deadline)
        external
        virtual
        override
        payable
        ensure(deadline)
        returns (uint32[] memory amounts)
    {
        require(path[0] == WETH, 'UniswapV2Router: INVALID_PATH');
        amounts = UniswapV2Library.getAmountsOut(factory, uint32(msg.value), path);
        require(amounts[amounts.length - 1] >= amountOutMin, 'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT');
        IWETH(WETH).deposit{value: amounts[0]}();
        assert(IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]));
        _swap(amounts, path, to);
    }
    function swapTokensForExactETH(uint32 amountOut, uint32 amountInMax, address[] calldata path, address to, uint32 deadline)
        external
        virtual
        override
        ensure(deadline)
        returns (uint32[] memory amounts)
    {
        require(path[path.length - 1] == WETH, 'UniswapV2Router: INVALID_PATH');
        amounts = UniswapV2Library.getAmountsIn(factory, amountOut, path);
        require(amounts[0] <= amountInMax, 'UniswapV2Router: EXCESSIVE_INPUT_AMOUNT');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        _swap(amounts, path, address(this));
        IWETH(WETH).withdraw(amounts[amounts.length - 1]);
        TransferHelper.safeTransferETH(to, amounts[amounts.length - 1]);
    }
    function swapExactTokensForETH(uint32 amountIn, uint32 amountOutMin, address[] calldata path, address to, uint32 deadline)
        external
        virtual
        override
        ensure(deadline)
        returns (uint32[] memory amounts)
    {
        require(path[path.length - 1] == WETH, 'UniswapV2Router: INVALID_PATH');
        amounts = UniswapV2Library.getAmountsOut(factory, amountIn, path);
        require(amounts[amounts.length - 1] >= amountOutMin, 'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]
        );
        _swap(amounts, path, address(this));
        IWETH(WETH).withdraw(amounts[amounts.length - 1]);
        TransferHelper.safeTransferETH(to, amounts[amounts.length - 1]);
    }
    function swapETHForExactTokens(uint32 amountOut, address[] calldata path, address to, uint32 deadline)
        external
        virtual
        override
        payable
        ensure(deadline)
        returns (uint32[] memory amounts)
    {
        require(path[0] == WETH, 'UniswapV2Router: INVALID_PATH');
        amounts = UniswapV2Library.getAmountsIn(factory, amountOut, path);
        require(amounts[0] <= uint32(msg.value), 'UniswapV2Router: EXCESSIVE_INPUT_AMOUNT');
        IWETH(WETH).deposit{value: amounts[0]}();
        assert(IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, path[0], path[1]), amounts[0]));
        _swap(amounts, path, to);
        // refund dust eth, if any
        if (uint32(msg.value) > amounts[0]) TransferHelper.safeTransferETH(msg.sender, uint32(msg.value) - amounts[0]);
    }

    // **** SWAP (supporting fee-on-transfer tokens) ****
    // requires the initial amount to have already been sent to the first pair
    function _swapSupportingFeeOnTransferTokens(address[] memory path, address _to) internal virtual {
        for (uint32 i = 0; i < uint32(path.length) - 1; i++) {
            (address input, address output) = (path[i], path[i + 1]);
            (address token0,) = UniswapV2Library.sortTokens(input, output);
            IUniswapV2Pair pair = IUniswapV2Pair(UniswapV2Library.pairFor(factory, input, output));
            uint32 amountInput;
            uint32 amountOutput;
            { // scope to avoid stack too deep errors
            (uint32 reserve0, uint32 reserve1,) = pair.getReserves();
            (uint32 reserveInput, uint32 reserveOutput) = input == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
            amountInput = IERC20(input).balanceOf(address(pair)).sub(reserveInput);
            amountOutput = UniswapV2Library.getAmountOut(amountInput, reserveInput, reserveOutput);
            }
            (uint32 amount0Out, uint32 amount1Out) = input == token0 ? (uint32(0), amountOutput) : (amountOutput, uint32(0));
            address to = i < path.length - 2 ? UniswapV2Library.pairFor(factory, output, path[i + 2]) : _to;
            pair.swap(amount0Out, amount1Out, to, new bytes(0));
        }
    }
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint32 amountIn,
        uint32 amountOutMin,
        address[] calldata path,
        address to,
        uint32 deadline
    ) external virtual override ensure(deadline) {
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amountIn
        );
        uint32 balanceBefore = IERC20(path[path.length - 1]).balanceOf(to);
        _swapSupportingFeeOnTransferTokens(path, to);
        require(
            IERC20(path[path.length - 1]).balanceOf(to).sub(balanceBefore) >= amountOutMin,
            'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT'
        );
    }
    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint32 amountOutMin,
        address[] calldata path,
        address to,
        uint32 deadline
    )
        external
        virtual
        override
        payable
        ensure(deadline)
    {
        require(path[0] == WETH, 'UniswapV2Router: INVALID_PATH');
        uint32 amountIn = uint32(msg.value);
        IWETH(WETH).deposit{value: amountIn}();
        assert(IWETH(WETH).transfer(UniswapV2Library.pairFor(factory, path[0], path[1]), amountIn));
        uint32 balanceBefore = IERC20(path[path.length - 1]).balanceOf(to);
        _swapSupportingFeeOnTransferTokens(path, to);
        require(
            IERC20(path[path.length - 1]).balanceOf(to).sub(balanceBefore) >= amountOutMin,
            'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT'
        );
    }
    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint32 amountIn,
        uint32 amountOutMin,
        address[] calldata path,
        address to,
        uint32 deadline
    )
        external
        virtual
        override
        ensure(deadline)
    {
        require(path[path.length - 1] == WETH, 'UniswapV2Router: INVALID_PATH');
        TransferHelper.safeTransferFrom(
            path[0], msg.sender, UniswapV2Library.pairFor(factory, path[0], path[1]), amountIn
        );
        _swapSupportingFeeOnTransferTokens(path, address(this));
        uint32 amountOut = IERC20(WETH).balanceOf(address(this));
        require(amountOut >= amountOutMin, 'UniswapV2Router: INSUFFICIENT_OUTPUT_AMOUNT');
        IWETH(WETH).withdraw(amountOut);
        TransferHelper.safeTransferETH(to, amountOut);
    }

    // **** LIBRARY FUNCTIONS ****
    function quote(uint32 amountA, uint32 reserveA, uint32 reserveB) public pure virtual override returns (uint32 amountB) {
        return UniswapV2Library.quote(amountA, reserveA, reserveB);
    }

    function getAmountOut(uint32 amountIn, uint32 reserveIn, uint32 reserveOut)
        public
        pure
        virtual
        override
        returns (uint32 amountOut)
    {
        return UniswapV2Library.getAmountOut(amountIn, reserveIn, reserveOut);
    }

    function getAmountIn(uint32 amountOut, uint32 reserveIn, uint32 reserveOut)
        public
        pure
        virtual
        override
        returns (uint32 amountIn)
    {
        return UniswapV2Library.getAmountIn(amountOut, reserveIn, reserveOut);
    }

    function getAmountsOut(uint32 amountIn, address[] memory path)
        public
        view
        virtual
        override
        returns (uint32[] memory amounts)
    {
        return UniswapV2Library.getAmountsOut(factory, amountIn, path);
    }

    function getAmountsIn(uint32 amountOut, address[] memory path)
        public
        view
        virtual
        override
        returns (uint32[] memory amounts)
    {
        return UniswapV2Library.getAmountsIn(factory, amountOut, path);
    }
}

// a library for performing overflow-safe math, courtesy of DappHub (https://github.com/dapphub/ds-math)

library SafeMath {
    function add(uint32 x, uint32 y) internal pure returns (uint32 z) {
        require((z = x + y) >= x, 'ds-math-add-overflow');
    }

    function sub(uint32 x, uint32 y) internal pure returns (uint32 z) {
        require((z = x - y) <= x, 'ds-math-sub-underflow');
    }

    function mul(uint32 x, uint32 y) internal pure returns (uint32 z) {
        require(y == 0 || (z = x * y) / y == x, 'ds-math-mul-overflow');
    }
}

library UniswapV2Library {
    using SafeMath for uint32;

    // returns sorted token addresses, used to handle return values from pairs sorted in this order
    function sortTokens(address tokenA, address tokenB) internal pure returns (address token0, address token1) {
        require(tokenA != tokenB, 'UniswapV2Library: IDENTICAL_ADDRESSES');
        (token0, token1) = tokenA < tokenB ? (tokenA, tokenB) : (tokenB, tokenA);
        require(token0 != address(0), 'UniswapV2Library: ZERO_ADDRESS');
    }

    // calculates the CREATE2 address for a pair without making any external calls
    function pairFor(address factory, address tokenA, address tokenB) internal pure returns (address pair) {
        (address token0, address token1) = sortTokens(tokenA, tokenB);
        pair = address(uint(keccak256(abi.encodePacked(
                hex'ff',
                factory,
                keccak256(abi.encodePacked(token0, token1)),
                hex'96e8ac4277198ff8b6f785478aa9a39f403cb768dd02cbee326c3e7da348845f' // init code hash
            ))));
    }

    // fetches and sorts the reserves for a pair
    function getReserves(address factory, address tokenA, address tokenB) internal view returns (uint32 reserveA, uint32 reserveB) {
        (address token0,) = sortTokens(tokenA, tokenB);
        (uint32 reserve0, uint32 reserve1,) = IUniswapV2Pair(pairFor(factory, tokenA, tokenB)).getReserves();
        (reserveA, reserveB) = tokenA == token0 ? (reserve0, reserve1) : (reserve1, reserve0);
    }

    // given some amount of an asset and pair reserves, returns an equivalent amount of the other asset
    function quote(uint32 amountA, uint32 reserveA, uint32 reserveB) internal pure returns (uint32 amountB) {
        require(amountA > 0, 'UniswapV2Library: INSUFFICIENT_AMOUNT');
        require(reserveA > 0 && reserveB > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        amountB = amountA.mul(reserveB) / reserveA;
    }

    // given an input amount of an asset and pair reserves, returns the maximum output amount of the other asset
    function getAmountOut(uint32 amountIn, uint32 reserveIn, uint32 reserveOut) internal pure returns (uint32 amountOut) {
        require(amountIn > 0, 'UniswapV2Library: INSUFFICIENT_INPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint32 amountInWithFee = amountIn.mul(997);
        uint32 numerator = amountInWithFee.mul(reserveOut);
        uint32 denominator = reserveIn.mul(1000).add(amountInWithFee);
        amountOut = numerator / denominator;
    }

    // given an output amount of an asset and pair reserves, returns a required input amount of the other asset
    function getAmountIn(uint32 amountOut, uint32 reserveIn, uint32 reserveOut) internal pure returns (uint32 amountIn) {
        require(amountOut > 0, 'UniswapV2Library: INSUFFICIENT_OUTPUT_AMOUNT');
        require(reserveIn > 0 && reserveOut > 0, 'UniswapV2Library: INSUFFICIENT_LIQUIDITY');
        uint32 numerator = reserveIn.mul(amountOut).mul(1000);
        uint32 denominator = reserveOut.sub(amountOut).mul(997);
        amountIn = (numerator / denominator).add(1);
    }

    // performs chained getAmountOut calculations on any number of pairs
    function getAmountsOut(address factory, uint32 amountIn, address[] memory path) internal view returns (uint32[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint32[](path.length);
        amounts[0] = amountIn;
        for (uint32 i = 0; i < uint32(path.length) - 1; i++) {
            (uint32 reserveIn, uint32 reserveOut) = getReserves(factory, path[i], path[i + 1]);
            amounts[i + 1] = getAmountOut(amounts[i], reserveIn, reserveOut);
        }
    }

    // performs chained getAmountIn calculations on any number of pairs
    function getAmountsIn(address factory, uint32 amountOut, address[] memory path) internal view returns (uint32[] memory amounts) {
        require(path.length >= 2, 'UniswapV2Library: INVALID_PATH');
        amounts = new uint32[](path.length);
        amounts[amounts.length - 1] = amountOut;
        for (uint32 i = uint32(path.length) - 1; i > 0; i--) {
            (uint32 reserveIn, uint32 reserveOut) = getReserves(factory, path[i - 1], path[i]);
            amounts[i - 1] = getAmountIn(amounts[i], reserveIn, reserveOut);
        }
    }
}

// helper methods for interacting with ERC20 tokens and sending ETH that do not consistently return true/false
library TransferHelper {
    function safeApprove(address token, address to, uint32 value) internal {
        // bytes4(keccak256(bytes('approve(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x095ea7b3, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: APPROVE_FAILED');
    }

    function safeTransfer(address token, address to, uint32 value) internal {
        // bytes4(keccak256(bytes('transfer(address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0xa9059cbb, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FAILED');
    }

    function safeTransferFrom(address token, address from, address to, uint32 value) internal {
        // bytes4(keccak256(bytes('transferFrom(address,address,uint256)')));
        (bool success, bytes memory data) = token.call(abi.encodeWithSelector(0x23b872dd, from, to, value));
        require(success && (data.length == 0 || abi.decode(data, (bool))), 'TransferHelper: TRANSFER_FROM_FAILED');
    }

    function safeTransferETH(address to, uint32 value) internal {
        (bool success,) = to.call{value:value}(new bytes(0));
        require(success, 'TransferHelper: ETH_TRANSFER_FAILED');
    }
}