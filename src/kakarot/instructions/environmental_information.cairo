// SPDX-License-Identifier: MIT

%lang starknet

// Starkware dependencies

from starkware.cairo.common.cairo_builtins import HashBuiltin

from starkware.cairo.common.uint256 import Uint256

// Internal dependencies
from kakarot.model import model
from utils.utils import Helpers
from kakarot.execution_context import ExecutionContext
from kakarot.stack import Stack

// @title Environmental information opcodes.
// @notice This file contains the functions to execute for environmental information opcodes.
// @author @abdelhamidbakhta
// @custom:namespace EnvironmentalInformation
namespace EnvironmentalInformation {
    // Define constants.
    const GAS_COST_CODESIZE = 2;

    // @notice CODESIZE operation.
    // @dev Get size of code running in current environment.
    // @custom:since Frontier
    // @custom:group Environmental Information
    // @custom:gas 3
    // @custom:stack_consumed_elements 0
    // @custom:stack_produced_elements 1
    // @return The pointer to the updated execution context.
    func exec_codesize{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
        ctx: model.ExecutionContext*
    ) -> model.ExecutionContext* {
        %{ print("0x38 - CODESIZE") %}
        // Get the code size.
        let code_size = Helpers.to_uint256(ctx.code_len);
        let stack: model.Stack* = Stack.push(ctx.stack, code_size);

        // Update the execution context.
        // Update context stack.
        let ctx = ExecutionContext.update_stack(ctx, stack);
        // Increment gas used.
        let ctx = ExecutionContext.increment_gas_used(ctx, GAS_COST_CODESIZE);
        return ctx;
    }
}
