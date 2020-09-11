import Foundation

// Produtos (Peças disponíveis)
//MARK: - Produto
class Produto {
    var nome: String
    var valor: Double
    
    init(nome: String, valor: Double) {
        self.nome = nome
        self.valor = valor
    }
}

// Itens dos produtos comprados
//MARK: - Item
class Item {
    var produto: Produto
    var quantidade: Int
    
    init(produto: Produto, quantidade: Int) {
        self.produto = produto
        self.quantidade = quantidade
    }
}

//MARK: - Vendedor
class Vendedor {
    private var nome: String
    private var idade: Int
    private var cpf: String
    private var saldoEmConta: Double = 0.0
    private var produtos = [Item]()
    
    init(nome: String, idade: Int, cpf: String) {
        self.nome = nome
        self.idade = idade
        self.cpf = cpf
    }
    
    //TODO: - Refatorar método para compra de um produto específico, isto é, tornar o método mais "enxuto"
    func vender(quantidadeDePecas: Int, tipoDePeca: String) {
        // terno = 400 (+3 350)
        // vestido = 900 (+5 ganha um véu = 250)
        // boné = 50 (+2 o 3 é grátis)
        var produto: Produto
        
        // Produto: Terno
        if tipoDePeca == "terno" {
            produto = Produto(nome: tipoDePeca, valor: 400)
            
            // Desconto
            if quantidadeDePecas >= 3 {
                produto.valor = 350
            }
            
            // Inserir produto no carrinho
            let item = Item(produto: produto, quantidade: quantidadeDePecas)
            self.produtos.append(item)
            self.atualizarSaldoEmConta(item: item)
            
          // Produto: Vestido
        } else if tipoDePeca == "vestido" {
            produto = Produto(nome: tipoDePeca, valor: 900)
            var item: Item
            
            // Brinde
            if quantidadeDePecas >= 5 {
                let brinde = Produto(nome: "véu", valor: -250.0)
                
                item = Item(produto: brinde, quantidade: 1)
                self.produtos.append(item)
                self.atualizarSaldoEmConta(item: item)
            }
            
            // Inserir produto no carrinho
            item = Item(produto: produto, quantidade: quantidadeDePecas)
            self.produtos.append(item)
            self.atualizarSaldoEmConta(item: item)
            
            // Produto: Boné
        } else if tipoDePeca == "boné" {
            produto = Produto(nome: tipoDePeca, valor: 50)
            var item: Item
            
            // Brinde
            if quantidadeDePecas >= 2 {
                let qtdBrindes = quantidadeDePecas / 2
                
                let brinde = Produto(nome: "boné", valor: 0)
                item = Item(produto: brinde, quantidade: qtdBrindes)
                self.produtos.append(item)
                self.atualizarSaldoEmConta(item: item)
            }
            
            // Inserir produto no carrinho
            item = Item(produto: produto, quantidade: quantidadeDePecas)
            self.produtos.append(item)
            self.atualizarSaldoEmConta(item: item)
            
            // Produto: Véu
        } else if tipoDePeca == "véu" {
            produto = Produto(nome: tipoDePeca, valor: 250)
            
            let item = Item(produto: produto, quantidade: quantidadeDePecas)
            self.produtos.append(item)
            self.atualizarSaldoEmConta(item: item)
        }
    }
    
    // Atualiza o saldo em conta ao comprar um produto
    private func atualizarSaldoEmConta(item: Item) {
        self.saldoEmConta = self.saldoEmConta + (Double(item.quantidade) * item.produto.valor)
    }
    
    // Mostrar saldo em conta
    func mostrarSaldoEmConta() -> Double {
        return self.saldoEmConta
    }
}

//MARK: - Instâncias
let vendedor = Vendedor(nome: "João", idade: 30, cpf: "12342342")

// Compra de terno
vendedor.vender(quantidadeDePecas: 3, tipoDePeca: "terno")
print(vendedor.mostrarSaldoEmConta())

// Compra de vestido
vendedor.vender(quantidadeDePecas: 5, tipoDePeca: "vestido")
print(vendedor.mostrarSaldoEmConta())

// Compra de boné
vendedor.vender(quantidadeDePecas: 2, tipoDePeca: "boné")
print(vendedor.mostrarSaldoEmConta())
