package com.runtoolkit.mce.item;

import com.runtoolkit.mce.MceCommandExecutor;
import com.runtoolkit.mce.gui.MceChestGui;
import net.minecraft.client.item.TooltipContext;
import net.minecraft.entity.player.PlayerEntity;
import net.minecraft.item.Item;
import net.minecraft.item.ItemStack;
import net.minecraft.server.network.ServerPlayerEntity;
import net.minecraft.text.Text;
import net.minecraft.util.Hand;
import net.minecraft.util.TypedActionResult;
import net.minecraft.world.World;

import java.util.List;

/** Item that performs an MCE action and applies a 30 second cooldown. */
public final class MceActionItem extends Item {
    public enum ActionType {
        OPEN_GUI,
        RUN_FUNCTION
    }

    private final ActionType actionType;
    private final String command;
    private final String tooltipKey;

    public MceActionItem(Settings settings, ActionType actionType, String command, String tooltipKey) {
        super(settings.maxCount(1));
        this.actionType = actionType;
        this.command = command;
        this.tooltipKey = tooltipKey;
    }

    @Override
    public TypedActionResult<ItemStack> use(World world, PlayerEntity user, Hand hand) {
        ItemStack stack = user.getStackInHand(hand);

        if (user.getItemCooldownManager().isCoolingDown(this)) {
            if (world.isClient) {
                user.sendMessage(Text.translatable("marker_command_engine.cooldown.active"), true);
            }
            return TypedActionResult.fail(stack);
        }

        user.getItemCooldownManager().set(this, MceItems.COOLDOWN_TICKS);

        if (!world.isClient && user instanceof ServerPlayerEntity serverPlayer) {
            if (this.actionType == ActionType.OPEN_GUI) {
                MceChestGui.open(serverPlayer);
            } else if (this.command != null && !this.command.isBlank()) {
                MceCommandExecutor.run(serverPlayer, this.command);
            }
        }

        return TypedActionResult.success(stack, world.isClient());
    }

    @Override
    public void appendTooltip(ItemStack stack, World world, List<Text> tooltip, TooltipContext context) {
        tooltip.add(Text.translatable(this.tooltipKey));
        tooltip.add(Text.translatable("marker_command_engine.tooltip.cooldown", MceItems.COOLDOWN_SECONDS));
    }
}
