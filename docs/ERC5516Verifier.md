# ERC5516Verifier









## Methods

### TOKEN_AMOUNT_FOR_AIRDROP_PER_ID

```solidity
function TOKEN_AMOUNT_FOR_AIRDROP_PER_ID() external view returns (uint256)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### TRANSFER_REQUEST_ID

```solidity
function TRANSFER_REQUEST_ID() external view returns (uint64)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint64 | undefined |

### addressToId

```solidity
function addressToId(address) external view returns (uint256)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### balanceOf

```solidity
function balanceOf(address account, uint256 id) external view returns (uint256)
```



*See {IERC1155-balanceOf}. Requirements: - `account` cannot be the zero address.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |
| id | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

### balanceOfBatch

```solidity
function balanceOfBatch(address[] accounts, uint256[] ids) external view returns (uint256[])
```



*See {IERC1155-balanceOfBatch}. Requirements: - `accounts` and `ids` must have the same length.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| accounts | address[] | undefined |
| ids | uint256[] | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256[] | undefined |

### batchTransfer

```solidity
function batchTransfer(address from, address[] to, uint256 id, uint256 amount, bytes data) external nonpayable
```



*See {eip-5516-batchTransfer} Requirements: - &#39;from&#39; must be the creator(minter) of `id` or must have allowed _msgSender() as an operator.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | undefined |
| to | address[] | undefined |
| id | uint256 | undefined |
| amount | uint256 | undefined |
| data | bytes | undefined |

### burn

```solidity
function burn(uint256 id) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint256 | undefined |

### burnBatch

```solidity
function burnBatch(uint256[] ids) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| ids | uint256[] | undefined |

### claimOrReject

```solidity
function claimOrReject(address account, uint256 id, bool action) external nonpayable
```



*See {eip-5516-claimOrReject} If action == true: Claims pending token under `id`. Else, rejects pending token under `id`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |
| id | uint256 | undefined |
| action | bool | undefined |

### claimOrRejectBatch

```solidity
function claimOrRejectBatch(address account, uint256[] ids, bool[] actions) external nonpayable
```



*See {eip-5516-claimOrReject} For each `id` - `action` pair: If action == true: Claims pending token under `id`. Else, rejects pending token under `id`.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |
| ids | uint256[] | undefined |
| actions | bool[] | undefined |

### contractUri

```solidity
function contractUri() external pure returns (string)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### getSupportedRequests

```solidity
function getSupportedRequests() external view returns (uint64[] arr)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| arr | uint64[] | undefined |

### getZKPRequest

```solidity
function getZKPRequest(uint64 requestId) external view returns (struct ICircuitValidator.CircuitQuery)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | uint64 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | ICircuitValidator.CircuitQuery | undefined |

### idToAddress

```solidity
function idToAddress(uint256) external view returns (address)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### isApprovedForAll

```solidity
function isApprovedForAll(address account, address operator) external view returns (bool)
```



*See {IERC1155-isApprovedForAll}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |
| operator | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### mint

```solidity
function mint(string data) external nonpayable
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| data | string | undefined |

### name

```solidity
function name() external view returns (string)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### owner

```solidity
function owner() external view returns (address)
```



*Returns the address of the current owner.*


#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |

### pendingFrom

```solidity
function pendingFrom(address account) external view returns (uint256[])
```



*Get tokens marked as _pendings of a given address Requirements: - `account` cannot be the zero address.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256[] | undefined |

### pendingURIFrom

```solidity
function pendingURIFrom(address account) external view returns (string[])
```



*Get the URI of the tokens owned by a given address. Requirements: - `account` cannot be the zero address.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string[] | undefined |

### proofs

```solidity
function proofs(address, uint64) external view returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | address | undefined |
| _1 | uint64 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### renounceOwnership

```solidity
function renounceOwnership() external nonpayable
```



*Leaves the contract without owner. It will not be possible to call `onlyOwner` functions anymore. Can only be called by the current owner. NOTE: Renouncing ownership will leave the contract without an owner, thereby removing any functionality that is only available to the owner.*


### requestQueries

```solidity
function requestQueries(uint64) external view returns (uint256 schema, uint256 claimPathKey, uint256 operator, uint256 queryHash, string circuitId)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint64 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| schema | uint256 | undefined |
| claimPathKey | uint256 | undefined |
| operator | uint256 | undefined |
| queryHash | uint256 | undefined |
| circuitId | string | undefined |

### requestValidators

```solidity
function requestValidators(uint64) external view returns (contract ICircuitValidator)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| _0 | uint64 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | contract ICircuitValidator | undefined |

### safeBatchTransferFrom

```solidity
function safeBatchTransferFrom(address from, address to, uint256[] ids, uint256[] amounts, bytes data) external nonpayable
```



*Unused/Deprecated functionSee {IERC1155-safeBatchTransferFrom}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | undefined |
| to | address | undefined |
| ids | uint256[] | undefined |
| amounts | uint256[] | undefined |
| data | bytes | undefined |

### safeTransferFrom

```solidity
function safeTransferFrom(address from, address to, uint256 id, uint256 amount, bytes data) external nonpayable
```



*See {IERC1155-safeTransferFrom}. Requirements: - `from` must be the creator(minter) of `id` or must have allowed _msgSender() as an operator.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| from | address | undefined |
| to | address | undefined |
| id | uint256 | undefined |
| amount | uint256 | undefined |
| data | bytes | undefined |

### setApprovalForAll

```solidity
function setApprovalForAll(address operator, bool approved) external nonpayable
```



*See {IERC1155-setApprovalForAll}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| operator | address | undefined |
| approved | bool | undefined |

### setZKPRequest

```solidity
function setZKPRequest(uint64 requestId, contract ICircuitValidator validator, uint256 schema, uint256 claimPathKey, uint256 operator, uint256[] value) external nonpayable returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | uint64 | undefined |
| validator | contract ICircuitValidator | undefined |
| schema | uint256 | undefined |
| claimPathKey | uint256 | undefined |
| operator | uint256 | undefined |
| value | uint256[] | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### setZKPRequestRaw

```solidity
function setZKPRequestRaw(uint64 requestId, contract ICircuitValidator validator, uint256 schema, uint256 claimPathKey, uint256 operator, uint256[] value, uint256 queryHash) external nonpayable returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | uint64 | undefined |
| validator | contract ICircuitValidator | undefined |
| schema | uint256 | undefined |
| claimPathKey | uint256 | undefined |
| operator | uint256 | undefined |
| value | uint256[] | undefined |
| queryHash | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### submitZKPResponse

```solidity
function submitZKPResponse(uint64 requestId, uint256[] inputs, uint256[2] a, uint256[2][2] b, uint256[2] c) external nonpayable returns (bool)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| requestId | uint64 | undefined |
| inputs | uint256[] | undefined |
| a | uint256[2] | undefined |
| b | uint256[2][2] | undefined |
| c | uint256[2] | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### supportsInterface

```solidity
function supportsInterface(bytes4 interfaceId) external view returns (bool)
```



*See {IERC165-supportsInterface}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| interfaceId | bytes4 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | bool | undefined |

### symbol

```solidity
function symbol() external view returns (string)
```






#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |

### tokensFrom

```solidity
function tokensFrom(address account) external view returns (uint256[])
```



*Get tokens owned by a given address Requirements: - `account` cannot be the zero address.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | uint256[] | undefined |

### tokensURIFrom

```solidity
function tokensURIFrom(address account) external view returns (string[])
```



*Get the URI of the tokens marked as pending of a given address. Requirements: - `account` cannot be the zero address.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| account | address | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string[] | undefined |

### transferOwnership

```solidity
function transferOwnership(address newOwner) external nonpayable
```



*Transfers ownership of the contract to a new account (`newOwner`). Can only be called by the current owner.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| newOwner | address | undefined |

### uri

```solidity
function uri(uint256 id) external view returns (string)
```



*See {IERC1155MetadataURI-uri}.*

#### Parameters

| Name | Type | Description |
|---|---|---|
| id | uint256 | undefined |

#### Returns

| Name | Type | Description |
|---|---|---|
| _0 | string | undefined |



## Events

### ApprovalForAll

```solidity
event ApprovalForAll(address indexed account, address indexed operator, bool approved)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| account `indexed` | address | undefined |
| operator `indexed` | address | undefined |
| approved  | bool | undefined |

### OwnershipTransferred

```solidity
event OwnershipTransferred(address indexed previousOwner, address indexed newOwner)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| previousOwner `indexed` | address | undefined |
| newOwner `indexed` | address | undefined |

### TokenClaimed

```solidity
event TokenClaimed(address indexed operator, address indexed account, bool[] actions, uint256[] ids)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| operator `indexed` | address | undefined |
| account `indexed` | address | undefined |
| actions  | bool[] | undefined |
| ids  | uint256[] | undefined |

### TransferBatch

```solidity
event TransferBatch(address indexed operator, address indexed from, address indexed to, uint256[] ids, uint256[] values)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| operator `indexed` | address | undefined |
| from `indexed` | address | undefined |
| to `indexed` | address | undefined |
| ids  | uint256[] | undefined |
| values  | uint256[] | undefined |

### TransferMulti

```solidity
event TransferMulti(address indexed operator, address indexed from, address[] to, uint256 amount, uint256 id)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| operator `indexed` | address | undefined |
| from `indexed` | address | undefined |
| to  | address[] | undefined |
| amount  | uint256 | undefined |
| id  | uint256 | undefined |

### TransferSingle

```solidity
event TransferSingle(address indexed operator, address indexed from, address indexed to, uint256 id, uint256 value)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| operator `indexed` | address | undefined |
| from `indexed` | address | undefined |
| to `indexed` | address | undefined |
| id  | uint256 | undefined |
| value  | uint256 | undefined |

### URI

```solidity
event URI(string value, uint256 indexed id)
```





#### Parameters

| Name | Type | Description |
|---|---|---|
| value  | string | undefined |
| id `indexed` | uint256 | undefined |



