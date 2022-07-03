function which = process (probs)
% Determines which process happens

r = rand * sum(probs);
which = 1;
s = probs(1);
while (r > s)
    which = which + 1;
    s = s + probs(which);
end

end