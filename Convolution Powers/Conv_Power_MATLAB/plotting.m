A = -0.75:0.01:0.75;
plot(sqrt(1-A.^4),A, 'Color', 'k');
hold on
plot(-sqrt(1-A.^4),-A, 'Color', 'k');

bb = (1-0.75^2)^(1/4);

B = -bb:0.01:bb;
plot(B,-(1-B.^2).^(1/4), '--', 'Color', 'b','LineWidth',2);
plot(-B,+(1-B.^2).^(1/4), '--', 'Color', 'b', 'LineWidth',2);
xlim([-1.1 1.1])
ylim([-1.1 1.1])
xlabel('X_1');
ylabel('X_2');
gtext('S_1', 'FontSize',16);
gtext('S_2', 'FontSize',16);
gtext('S_3', 'FontSize',16);
gtext('S_4', 'FontSize',16);
hold off
